class CreateProveedores < ActiveRecord::Migration
  def self.up
    create_table :proveedores do |t|
      t.string :nombre
      t.string :codigo_agrupacion
      t.text :observaciones
      t.string :domicilio
      t.string :ciudad
      t.string :codigo_postal
      t.string :provincia
      t.string :telefonos
      t.string :fax
      t.string :e_mail
      t.string :area_geografica
      t.date :fec_grab
      t.string :hor_grab
      t.string :usr_grab
      t.string :wks_grab
      t.string :tip_grab

      t.timestamps
    end
  end

  def self.down
    drop_table :proveedores
  end
end
