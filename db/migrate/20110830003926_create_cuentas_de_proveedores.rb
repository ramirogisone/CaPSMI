class CreateCuentasDeProveedores < ActiveRecord::Migration
  def self.up
    create_table :cuentas_de_proveedores do |t|
      t.belongs_to :comprobante_de_compra
      t.date :fecha
      t.string :tipo
      t.integer :centro
      t.integer :numero
      t.belongs_to :proveedor
      t.string :clase_valor
      t.integer :lote_valor
      t.integer :numero_valor
      t.date :fecha_valor
      t.string :movimiento
      t.float :importe
      t.string :tipo_aplicado
      t.integer :centro_aplicado
      t.integer :numero_aplicado
      t.date :fecha_aplicado
      t.date :vencimiento
      t.string :detalle
      t.date :fec_grab
      t.string :hor_grab
      t.string :wks_grab
      t.string :tip_grab
      t.string :usr_grab
      t.integer :rec_grab

      t.timestamps
    end
  end

  def self.down
    drop_table :cuentas_de_proveedores
  end
end
