class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :posicion
      t.string :nombre
      t.string :controlador
      t.string :accion
      t.string :estado
      t.string :formato

      t.timestamps
    end
  end

  def self.down
    drop_table :links
  end
end
