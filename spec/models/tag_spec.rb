require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "バリデーション" do
    it "名前があれば作成可能" do
      expect(build(:tag)).to be_valid
    end

    it "すでに同じ名前のタグが存在する場合、作成できない" do
      create(:tag, :rails)
      expect(build(:tag, :rails)).not_to be_valid
    end

    it "名前がなければ作成できない" do
      expect(build(:tag, name: nil)).not_to be_valid
    end
  end

  describe "スコープ" do
    describe "#search" do
      it "引数に部分一致するタグを返す" do
        tag_1 = create(:tag)
        tag_2 = create(:tag)
        tag_3 = create(:tag, :rails)
        expect(Tag.search("tag")).to include tag_1, tag_2
      end
    end
  end
end
