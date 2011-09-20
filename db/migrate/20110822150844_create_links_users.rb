class CreateLinksUsers < ActiveRecord::Migration
  def self.up
    create_table :links_users do |t|
      t.belongs_to :opcion
      t.belongs_to :usuario
      t.boolean :alta
      t.boolean :baja
      t.boolean :modificacion

      t.timestamps
    end
  end

  def self.down
    drop_table :links_users
  end
end
