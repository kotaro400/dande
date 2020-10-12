class ChangeArticleTagColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :article_tags, :article_id
    remove_column :article_tags, :tag_id
    add_reference :article_tags, :article, foreign_key: true
    add_reference :article_tags, :tag, foreign_key: true
  end
end
