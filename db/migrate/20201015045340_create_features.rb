class CreateFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :features do |t|
      t.string :title, null: false
      t.text :details
      t.boolean :for_engineer
      t.boolean :for_designer
      t.timestamps
    end
  end
end
