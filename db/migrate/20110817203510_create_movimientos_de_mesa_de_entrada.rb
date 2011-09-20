class CreateMovimientosDeMesaDeEntrada < ActiveRecord::Migration
  def self.up
    create_table :movimientos_de_mesa_de_entrada do |t|
      t.belongs_to :comprobante_de_mesa_de_entrada
      t.belongs_to :expediente
      t.belongs_to :instancia_origen
      t.belongs_to :instancia_destino
      t.string :tipo

      t.timestamps
    end
  end

  def self.down
    drop_table :movimientos_de_mesa_de_entrada
  end
end
