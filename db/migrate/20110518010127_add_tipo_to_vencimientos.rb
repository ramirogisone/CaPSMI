class AddTipoToVencimientos < ActiveRecord::Migration
  def self.up
    add_column :vencimientos, :tipo, :string
  end

  def self.down
    remove_column :vencimientos, :tipo
  end
end
