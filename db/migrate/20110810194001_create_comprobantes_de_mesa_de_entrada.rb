class CreateComprobantesDeMesaDeEntrada < ActiveRecord::Migration
  def self.up
    create_table :comprobantes_de_mesa_de_entrada do |t|
      t.string :tipo
      t.date :fecha
      t.integer :numero
      t.belongs_to :user
      t.text :observaciones

      t.timestamps
    end
  end

  def self.down
    drop_table :comprobantes_de_mesa_de_entrada
  end
end
