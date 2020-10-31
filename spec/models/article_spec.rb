require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "バリデーション" do
    before do
      @article = build(:article)
      @article.image = fixture_file_upload('app/assets/images/white-logo.png')
    end

    it "サムネイルとタイトルがあれば作成可能" do
      expect(@article).to be_valid
    end

    it "タイトルがなければ作成できない" do
      @article.title = nil
      expect(@article).not_to be_valid
    end

    it "サムネイルがなければ作成できない" do
      @article.image = nil
      expect(@article).not_to be_valid
    end

    it "サムネイルはjpegかpng" do
      @article.image = fixture_file_upload('app/assets/images/hamburger.svg')
      expect(@article).not_to be_valid
    end
  end

  describe "スコープ" do
    before do
      @article_1 = create(:article)
      @article_2 = create(:article, title: "rails")
      @article_3 = create(:article, title: "ruby on rails")
      @article_4 = create(:article, :draft, title: "railsの下書き")
      @article_5 = create(:article, :for_designer_only)
      @article_6 = create(:article, :for_engineer_only)
    end

    describe "#search" do
      it "指定した語句がタイトルに含まれる記事を返す" do
        expect(Article.search("rails")).to include @article_3, @article_2
      end
    end

    describe "#sort_from_newest_to_oldest" do
      it "記事を新しい順に並べる" do
        expect(Article.sort_from_newest_to_oldest.first).to eq @article_6
      end
    end

    describe "#on_public" do
      it "公開中の記事を返す" do
        expect(Article.on_public).to include @article_6, @article_5, @article_3, @article_2, @article_1
      end
    end

    describe "#draft" do
      it "下書きの記事を返す" do
        expect(Article.draft).to include @article_4
      end
    end

    describe "#for_engineer" do
      it "エンジニア向けの記事のみ返す" do
        expect(Article.for_engineer).to include @article_6, @article_3, @article_2, @article_1
      end
    end

    describe "#for_designer" do
      it "デザイナー向けの記事のみ返す" do
        expect(Article.for_designer).to include @article_5, @article_3, @article_2, @article_1
      end
    end

    describe "#for_engineer_or_designer" do
      it "デザイナーかエンジニア向けの記事を返す" do
        expect(Article.for_engineer_or_designer).to include @article_6, @article_5, @article_3, @article_2, @article_1
      end
    end

    describe "#self.filter" do
      before do
        @article_1 = create(:article)
        @article_2 = create(:article, title: "rails")
        @article_3 = create(:article, title: "ruby on rails")
        @article_4 = create(:article, :draft, title: "railsの下書き")
        @article_5 = create(:article, :for_designer_only)
        @article_6 = create(:article, :for_engineer_only)
      end

      it "paramsにwordが含まれていれば語句検索結果を返す" do
        expect(Article.filter({word: "rails"})).to include @article_3, @article_2
      end

      it "paramsのfor_engineerとfor_designerが真ならばエンジニアかデザイナー向けの記事を返す" do
        expect(Article.filter({for_engineer: true, for_designer: true})).to include @article_6, @article_5, @article_3, @article_2, @article_1
      end

      it "paramsのfor_engineerが真ならばエンジニア向けの記事を返す" do
        expect(Article.filter({for_engineer: true})).to include @article_6, @article_3, @article_2, @article_1
      end

      it "paramsのfor_designerが真ならばデザイナー向けの記事を返す" do
        expect(Article.filter({for_designer: true})).to include @article_5, @article_3, @article_2, @article_1
      end

      it "paramsにtag名が含まれれば、そのタグをもつ記事を返す" do
        tag = create(:tag, :rails)
        @article_2.tags << tag
        @article_3.tags << tag
        @article_4.tags << tag
        expect(Article.filter({tag: "rails"})).to include @article_3, @article_2
      end

      it "paramsに何も含まれていなければ公開中の記事を返す" do
        expect(Article.filter({})).to include @article_6, @article_5, @article_3, @article_2, @article_1
      end
    end
  end
end
