require 'rails_helper'

RSpec.describe 'Tags', type: :system do
  describe "タグの追加" do
    before do
      visit "owners/sign_in"
      fill_in "owner_uid", with: ENV["ENGINEER_UID"]
      fill_in "owner_password", with: ENV["ENGINEER_PWD"]
      click_on "ログインする"
      visit new_article_path
    end

    describe "タグを新規作成" do
      scenario "タグを作成することができる" do
        find("#new-tag-link").click
        fill_in "tag_name", with: "rspec"
        click_on "追加"
        expect(page).to have_css "#added-tags"
        expect(page).to have_content "rspec"
      end

      scenario "すでに存在している名前のタグは作成できない" do
        @tag = create(:tag)
        find("#new-tag-link").click
        fill_in "tag_name", with: @tag.name
        click_on "追加"
        expect(page).to have_css ".error-messages"
      end
    end

    describe "既存のタグを追加" do
      scenario "タグを検索して追加することができる" do
        @tag = create(:tag)
        find("#new-tag-link").click
        fill_in "word", with: @tag.name
        click_on "検索"
        find("#res-tag-#{@tag.id}").click
        expect(page).to have_css "#added-tags"
        expect(page).to have_content @tag.name
      end
    end
  end
end
