class AddLegajoToLegajos < ActiveRecord::Migration
	def self.up
		add_column :legajos, :legajo, :integer
	end

	def self.down
		remove_column :legajos, :legajo
	end
end
