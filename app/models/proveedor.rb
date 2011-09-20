class Proveedor < ActiveRecord::Base

	cattr_reader :per_page
	@@per_page = 24

	validates_presence_of :nombre, :regimen_iva, :message => "no puede estar vacio."
	validates_numericality_of :cuit, :message => "debe ser un numero."

	def after_find
		self.cuit = self.cuit.round
	end

end
