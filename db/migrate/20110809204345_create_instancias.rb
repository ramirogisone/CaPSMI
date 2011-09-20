class CreateInstancias < ActiveRecord::Migration
  def self.up
    create_table :instancias do |t|
      t.string :nombre
      t.text :observaciones

      t.timestamps
    end
  end

  def self.down
    drop_table :instancias
  end
end
