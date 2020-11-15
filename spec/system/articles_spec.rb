require 'rails_helper'

RSpec.describe 'Articles', type: :system do
  context "ログインしていない場合"  do
    before do
      create(:article, :draft, title: "下書き")

      visit "owners/sign_in"
      fill_in "owner_uid", with: ENV["ENGINEER_UID"]
      fill_in "owner_password", with: ENV["ENGINEER_PWD"]
      click_on "ログインする"
      visit "articles/new"
      fill_in "タイトル", with: "タイトル"
      check "article_open"
      check "article_for_engineer"
      attach_file "article_image", "app/assets/images/white-logo.png", make_visible: true
      fill_in_rich_text_area "article_content", with: "<h1>見出し</h1><p>本文</p><h1>見出し2</h1><p>本文2</p>"
      click_on "保存"

      page.accept_confirm do
        find("#logout-link").click
      end
    end

    describe "トップページ" do
      before do
        visit root_path
      end

      scenario "公開されている記事が表示される" do
        expect(page).to have_content "タイトル"
        expect(page).not_to have_content "下書き"
      end

      scenario "記事の検索ができる" do
        fill_in "word", with: "Rails"
        click_on "検索"
        expect(page).not_to have_content "タイトル"
      end
    end

    scenario "記事の作成はできない" do
      visit new_article_path
      expect(current_path).to eq root_path
    end

    scenario "記事の編集はできない" do
      visit edit_article_path(Article.first)
      expect(current_path).to eq root_path
    end

    scenario "記事の削除ができない" do
      visit Article.first
      expect(page).not_to have_css "#destroy-article-link"
    end
  end

  context "ログインしている場合"  do
    before do
      visit "owners/sign_in"
      fill_in "owner_uid", with: ENV["ENGINEER_UID"]
      fill_in "owner_password", with: ENV["ENGINEER_PWD"]
      click_on "ログインする"
    end

    describe "記事作成" do
      before do
        find("#plus-btn").click
        click_on "新規記事を作成"
      end

      scenario "記事を作成できる" do
        fill_in "タイトル", with: "タイトル"
        attach_file "article_image", "app/assets/images/white-logo.png", make_visible: true
        fill_in_rich_text_area "article_content", with: "<h1>見出し</h1><p>本文</p>"
        click_on "保存"
        expect(current_path).to eq articles_path
        expect(Article.first.title).to eq "タイトル"
      end

      scenario "不備があると作成できない" do
        click_on "保存"
        expect(page).to have_css ".error-messages"
      end
    end

    describe "記事編集" do
      before do
        @article = create(:article)
      end

      scenario "記事の詳細画面に編集画面へのリンクがある" do
        visit "articles/#{@article.id}"
        click_on "この記事を編集"
        expect(current_path).to eq "/articles/#{@article.id}/edit"
      end

      scenario "既存記事の編集ができる" do
        visit "articles/#{@article.id}/edit"
        fill_in "タイトル", with: "編集後のタイトル"
        fill_in_rich_text_area "article_content", with: "<h1>編集後の見出し</h1><p>本文</p>"
        click_on "保存"
        visit "articles/#{@article.id}"
        expect(page).to have_content "編集後のタイトル"
        expect(page).to have_content "編集後の見出し"
      end

      scenario "不備があれば保存できない" do
        visit "articles/#{@article.id}/edit"
        fill_in "タイトル", with: nil
        click_on "保存"
        expect(page).to have_css ".error-messages"
      end
    end

    describe "記事削除" do
      before do
        @article = create(:article)
      end

      scenario "詳細画面から記事の削除ができる" do
        visit "articles/#{@article.id}"
        page.accept_confirm do
          find("#destroy-article-link").click
        end
        expect(page).to have_content "New"
        expect(Article.all.count).to eq 0
      end
    end
  end
end
