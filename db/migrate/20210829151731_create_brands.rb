class CreateBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :brands do |t|
      t.string :name,null: false,uniqure:true,index:true
      t.timestamps
    end
  end
end
