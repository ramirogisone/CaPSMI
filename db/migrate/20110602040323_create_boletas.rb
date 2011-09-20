class CreateBoletas < ActiveRecord::Migration
	def self.up
		create_table :boletas do |t|
			t.date :vencimiento
			t.belongs_to :afiliado
			t.float :total

			t.timestamps
		end
	end

	def self.down
		drop_table :boletas
	end
end
