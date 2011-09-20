class Boleta < ActiveRecord::Base

	attr_accessor :nombre_afiliado

	cattr_reader :per_page
	@@per_page = 24

	belongs_to :afiliado
	has_and_belongs_to_many :vencimientos

	def after_find
		self.nombre_afiliado = self.afiliado ? self.afiliado.nombre : 'No hay afiliado.'
		self.vencimiento = vencimiento
		self.created_at = created_at
	end

end
