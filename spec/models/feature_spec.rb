require 'rails_helper'

RSpec.describe Feature, type: :model do
  describe "バリデーション" do
    before do
      @feature = build(:feature)
      @feature.image = fixture_file_upload('app/assets/images/white-logo.png')
    end

    it "サムネイルとタイトルがあれば作成可能" do
      expect(@feature).to be_valid
    end

    it "タイトルがなければ作成できない" do
      @feature.title = nil
      expect(@feature).not_to be_valid
    end

    it "サムネイルがなければ作成できない" do
      @feature.image = nil
      expect(@feature).not_to be_valid
    end

    it "サムネイルはjpegかpng" do
      @feature.image = fixture_file_upload('app/assets/images/hamburger.svg')
      expect(@feature).not_to be_valid
    end
  end

  describe "スコープ" do
    it "#sort_from_newest_to_oldest" do
      @feature_1 = create(:feature)
      @feature_2 = create(:feature)
      expect(Feature.sort_from_newest_to_oldest.first).to eq @feature_2
    end
  end
end
