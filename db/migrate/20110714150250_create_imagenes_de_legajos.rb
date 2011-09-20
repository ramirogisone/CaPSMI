class CreateImagenesDeLegajos < ActiveRecord::Migration
  def self.up
    create_table :imagenes_de_legajos do |t|
      t.belongs_to :legajo
      t.string :tipo
      t.string :nombre

      t.timestamps
    end
  end

  def self.down
    drop_table :imagenes_de_legajos
  end
end
