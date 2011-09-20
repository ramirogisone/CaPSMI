class CreateExpedientes < ActiveRecord::Migration
  def self.up
    create_table :expedientes do |t|
      t.string :nombre
      t.belongs_to :tipo_de_expediente
      t.text :observaciones
      t.belongs_to :afiliado
      t.date :fecha_de_apertura
      t.date :fecha_de_cierre

      t.timestamps
    end
  end

  def self.down
    drop_table :expedientes
  end
end
