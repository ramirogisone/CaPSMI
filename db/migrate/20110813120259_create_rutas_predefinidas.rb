class CreateRutasPredefinidas < ActiveRecord::Migration
  def self.up
    create_table :rutas_predefinidas do |t|
      t.belongs_to :tipo_de_expediente
      t.belongs_to :instancia
      t.integer :paso
      t.integer :dias_plazo

      t.timestamps
    end
  end

  def self.down
    drop_table :rutas_predefinidas
  end
end
