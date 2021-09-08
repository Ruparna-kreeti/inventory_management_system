class AddColumnToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :google_token, :string
    add_column :employees, :google_refresh_token, :string
  end
end
