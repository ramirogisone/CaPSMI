class HabtmBoletasVencimientos < ActiveRecord::Migration
	def self.up
		create_table :boletas_vencimientos, :id => false do |t|
			t.belongs_to :boleta
			t.belongs_to :vencimiento
		end
	end

	def self.down
		drop_table :boletas_vencimientos
	end
end
