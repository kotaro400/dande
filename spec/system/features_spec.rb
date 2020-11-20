require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  describe "ログインしていない場合" do
    before do
      @feature = create(:feature)
      @article = create(:article, feature: @feature)
    end

    describe "特集一覧" do
      scenario "トップページにリンクが存在する" do
        visit root_path
        click_on "Feature"
        expect(current_path).to eq features_path
      end

      scenario "特集の一覧が表示される" do
        visit features_path
        expect(page).to have_content @feature.title
        expect(page).to have_content @feature.details
      end

      scenario "各特集へのリンクが存在する" do
        visit features_path
        click_on @feature.title
        expect(current_path).to eq feature_path(@feature)
      end
    end

    describe "特集詳細" do
      scenario "タイトル、詳細、記事のタイトルが表示される" do
        visit feature_path(@feature)
        expect(page).to have_content @feature.title
        expect(page).to have_content @feature.details
        expect(page).to have_content @article.title
      end

      scenario "記事のリンクが存在する" do
        visit feature_path(@feature)
        click_on @article.title
        expect(current_path).to eq article_path(@article)
      end
    end

    scenario "特集の作成ができない" do
      visit new_feature_path
      expect(current_path).to eq root_path
    end

    scenario "特集の編集ができない" do
      visit edit_feature_path(@feature)
      expect(current_path).to eq root_path
    end

    scenario "特集詳細画面に編集と削除のリンクが存在しない" do
      visit feature_path(@feature)
      expect(page).not_to have_content "この特集を編集"
      expect(page).not_to have_css "#destroy-article-link"
    end
  end

  describe "ログインしている場合" do
    before do
      visit "owners/sign_in"
      fill_in "owner_uid", with: ENV["ENGINEER_UID"]
      fill_in "owner_password", with: ENV["ENGINEER_PWD"]
      click_on "ログインする"
    end

    describe "特集作成" do
      before do
        find("#plus-btn").click
        click_on "新規特集を作成"
      end

      scenario "特集の作成ができる" do
        fill_in "タイトル", with: "タイトル"
        attach_file "feature_image", "app/assets/images/white-logo.png", make_visible: true
        click_on "公開"
        expect(current_path).to eq root_path
        expect(Feature.first.title).to eq "タイトル"
      end

      scenario "不備があると作成できない" do
        attach_file "feature_image", "app/assets/images/white-logo.png", make_visible: true
        click_on "公開"
        expect(page).to have_css ".error-messages"
      end
    end

    describe "特集編集" do
      before do
        @feature = create(:feature)
      end

      scenario "特集の詳細画面に編集画面へのリンクがある" do
        visit feature_path(@feature)
        click_on "この特集を編集"
        expect(current_path).to eq edit_feature_path(@feature)
      end

      scenario "編集が可能" do
        visit edit_feature_path(@feature)
        fill_in "タイトル", with: "編集後のタイトル"
        click_on "公開"
        visit feature_path(@feature)
        expect(page).to have_content "編集後のタイトル"
      end

      scenario "不備があれば保存できない" do
        visit edit_feature_path(@feature)
        fill_in "タイトル", with: nil
        click_on "公開"
        expect(page).to have_css ".error-messages"
      end
    end

    describe "特集削除" do
      before do
        @feature = create(:feature)
      end

      scenario "特集の編集画面から特集の削除が可能" do
        visit feature_path(@feature)
        page.accept_confirm do
          find("#destroy-article-link").click
        end
        expect(page).to have_content "New"
        expect(Feature.all.count).to eq 0
      end

      scenario "特集に含まれている記事は削除されない" do
        create(:article, feature: @feature)
        visit feature_path(@feature)
        page.accept_confirm do
          find("#destroy-article-link").click
        end
        expect(Article.all.count).to eq 1
      end
    end

    describe "特集に記事を追加" do
      before do
        @feature = create(:feature)
        visit new_article_path
      end

      scenario "記事の追加が可能" do
        fill_in "タイトル", with: "タイトル"
        attach_file "article_image", "app/assets/images/white-logo.png", make_visible: true
        fill_in_rich_text_area "article_content", with: "<h1>見出し</h1><p>本文</p>"
        select @feature.title, from: "article_feature"
        click_on "保存"
        expect(@feature.articles.first.title).to eq "タイトル"
      end
    end
  end
end
