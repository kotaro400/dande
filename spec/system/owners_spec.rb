require 'rails_helper'

RSpec.describe 'Owners', type: :system do
  describe "ログイン" do
    scenario "エンジニアがログインできる" do
      visit "owners/sign_in"
      fill_in "owner_uid", with: ENV["ENGINEER_UID"]
      fill_in "owner_password", with: ENV["ENGINEER_PWD"]
      click_on "ログインする"
      expect(current_path).to eq root_path
      expect(page).to have_css ".owner-header"
      expect(page).to have_css "#plus-btn"
    end

    scenario "デザイナーがログインできる" do
      visit "owners/sign_in"
      fill_in "owner_uid", with: ENV["DESIGNER_UID"]
      fill_in "owner_password", with: ENV["DESIGNER_PWD"]
      click_on "ログインする"
      expect(current_path).to eq root_path
      expect(page).to have_css ".owner-header"
      expect(page).to have_css "#plus-btn"
    end

    scenario "ログインに失敗する" do
      visit "owners/sign_in"
      fill_in "owner_uid", with: "uid"
      fill_in "owner_password", with: "password"
      click_on "ログインする"
      expect(page).to have_content "ログイン"
    end
  end

  describe "ログアウト" do
    scenario "ログアウトすることができる" do
      visit "owners/sign_in"
      fill_in "owner_uid", with: ENV["ENGINEER_UID"]
      fill_in "owner_password", with: ENV["ENGINEER_PWD"]
      click_on "ログインする"
      page.accept_confirm do
        find("#logout-link").click
      end
      expect(current_path).to eq root_path
      expect(page).not_to have_css ".owner-header"
    end
  end
end
