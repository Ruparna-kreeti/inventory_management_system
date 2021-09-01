class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :brand, null: false, foreign_key: true
      t.references :category,null: false,foreign_key: true
      t.string :name,null:false,index:true
      t.text :notes,null: false
      t.integer :buffer_quantity,null: false
      t.timestamps
    end
  end
end
