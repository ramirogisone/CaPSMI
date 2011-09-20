class AddPasswordFieldToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :password_field, :string
  end

  def self.down
    remove_column :users, :password_field
  end
end
