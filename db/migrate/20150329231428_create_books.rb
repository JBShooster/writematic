class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :cover
      t.string :content
      t.string :description
      t.string :pages
      t.string :hits
      t.integer :category
      t.string :publish_date

      t.timestamps null: false
    end
  end
end
