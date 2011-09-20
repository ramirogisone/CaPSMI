class AddRegimenIvaAndCuitToProveedores < ActiveRecord::Migration
	def self.up
		add_column :proveedores, :regimen_iva, :string
		add_column :proveedores, :cuit, :float
	end
	
	def self.down
		remove_column :proveedores, :regimen_iva
		remove_column :proveedores, :cuit
	end
end
