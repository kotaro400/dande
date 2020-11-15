require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  describe "ログインしていない場合" do

  end

  describe "ログインしている場合" do
    before do
      visit "owners/sign_in"
      fill_in "owner_uid", with: ENV["ENGINEER_UID"]
      fill_in "owner_password", with: ENV["ENGINEER_PWD"]
      click_on "ログインする"
    end

    describe "特集作成" do
      scenario "特集の作成ができる" do
        find("#plus-btn").click
        click_on "新規特集を作成"
        fill_in "タイトル", with: "タイトル"
        attach_file "feature_image", "app/assets/images/white-logo.png", make_visible: true
        click_on "公開"
        expect(current_path).to eq root_path
        expect(Feature.first.title).to eq "タイトル"
      end
    end
  end
end
