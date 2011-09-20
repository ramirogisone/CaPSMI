class CreateTiposDeExpedientes < ActiveRecord::Migration
  def self.up
    create_table :tipos_de_expedientes do |t|
      t.string :posicion
      t.string :nombre
      t.text :observacion

      t.timestamps
    end
  end

  def self.down
    drop_table :tipos_de_expedientes
  end
end
