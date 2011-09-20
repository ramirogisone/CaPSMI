class CreateLegajos < ActiveRecord::Migration
  def self.up
    create_table :legajos do |t|
      t.string :apellido
      t.string :nombres
      t.date :nacimiento
      t.string :tipo_documento
      t.float :documento
      t.float :cuil
      t.string :estado_civil
      t.string :domicilio
      t.string :ciudad
      t.string :codigo_postal
      t.string :telefonos
      t.date :ingreso
      t.string :categoria
      t.date :egreso

      t.timestamps
    end
  end

  def self.down
    drop_table :legajos
  end
end
