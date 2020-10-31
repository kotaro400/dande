class ChangeColumnNameOfArticles < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :public, :open
  end
end
