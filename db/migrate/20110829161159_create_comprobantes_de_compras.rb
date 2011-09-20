class CreateComprobantesDeCompras < ActiveRecord::Migration
  def self.up
    create_table :comprobantes_de_compras do |t|
      t.date :fecha
      t.string :tipo
      t.integer :centro
      t.integer :numero
      t.belongs_to :proveedor
      t.belongs_to :user
      t.string :domicilio
      t.string :ciudad
      t.string :codigo_postal
      t.string :provincia
      t.string :telefonos
      t.string :regimen_iva
      t.float :total
      t.date :fec_grab
      t.string :hor_grab
      t.string :usr_grab
      t.string :wks_grab
      t.string :tip_grab

      t.timestamps
    end
  end

  def self.down
    drop_table :comprobantes_de_compras
  end
end
