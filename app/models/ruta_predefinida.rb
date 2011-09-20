class RutaPredefinida < ActiveRecord::Base

	attr_accessor :nombre_instancia
	
	belongs_to :tipo_de_expediente
	belongs_to :instancia
	
	cattr_reader :per_page
	@@per_page = 24
	
	validates_presence_of :instancia_id, :paso, :message => "no puede estar vacío."
	validates_numericality_of :paso, :dias_plazo, :message => "debe ser un número."
	validate :paso_mayor_cero
	validates_uniqueness_of :paso, :scope => :tipo_de_expediente_id, :message => "ya existe para este tipo."
	
	def after_find
		self.nombre_instancia = self.instancia ? self.instancia.nombre : "No hay instancia: #{@instancia_id}"
	end

	def initialize(*args)
		super(*args)
		self.dias_plazo = 30 unless self.dias_plazo
	end

	def paso_mayor_cero 
		if self.paso_before_type_cast.to_f <= 0
		  errors.add(:paso, 'debe ser mayor que cero')
		  return false
		end
	end

end
