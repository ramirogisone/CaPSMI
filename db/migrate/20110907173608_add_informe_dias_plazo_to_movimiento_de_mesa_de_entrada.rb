class AddInformeDiasPlazoToMovimientoDeMesaDeEntrada < ActiveRecord::Migration
	def self.up
		add_column :movimientos_de_mesa_de_entrada, :informe, :text
		add_column :movimientos_de_mesa_de_entrada, :dias_plazo, :integer
	end
	
	def self.down
		remove_column :movimientos_de_mesa_de_entrada, :dias_plazo
		remove_column :movimientos_de_mesa_de_entrada, :informe
	end
end
