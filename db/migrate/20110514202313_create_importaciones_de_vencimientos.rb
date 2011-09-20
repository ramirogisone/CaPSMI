class CreateImportacionesDeVencimientos < ActiveRecord::Migration
  def self.up
    create_table :importaciones_de_vencimientos do |t|
      t.date :fecha
      t.text :informe

      t.timestamps
    end
  end

  def self.down
    drop_table :importaciones_de_vencimientos
  end
end
