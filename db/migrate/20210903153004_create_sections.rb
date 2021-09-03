class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.references :user,null: false,foreign_key: true
      t.boolean :employee,null: false,default: false
      t.boolean :brand,null: false,default: false
      t.boolean :category,null: false,default: false
      t.boolean :item,null: false,default: false
      t.boolean :storage,null: false,default: false
      t.boolean :issue,null: false,default: false
      t.timestamps
    end
  end
end
