class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name,null: false,uniqure:true,index:true
      t.timestamps
    end
  end
end
