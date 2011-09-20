class CreateVencimientos < ActiveRecord::Migration
  def self.up
    create_table :vencimientos do |t|
      t.belongs_to :afiliado
      t.string :tipo_comprobante
      t.integer :centro_comprobante, :default => 0
      t.float :numero_comprobante, :default => 0
      t.date :fecha_comprobante, :default => Date.today
      t.date :vencimiento, :default => Date.today
      t.string :detalle
      t.float :importe, :default => 0.00

      t.timestamps
    end
  end

  def self.down
    drop_table :vencimientos
  end
end
