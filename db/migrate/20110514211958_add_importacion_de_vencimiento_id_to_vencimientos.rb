class AddImportacionDeVencimientoIdToVencimientos < ActiveRecord::Migration
  def self.up
    add_column :vencimientos, :importacion_de_vencimiento_id, :integer
  end

  def self.down
    remove_column :vencimientos, :importacion_de_vencimiento_id
  end
end
