class AddReferenceToArticle < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :feature, foreign_key: true
  end
end
