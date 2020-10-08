class ChangeArticleColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :for
    add_column :articles, :for_engineer, :boolean
    add_column :articles, :for_designer, :boolean
  end
end
