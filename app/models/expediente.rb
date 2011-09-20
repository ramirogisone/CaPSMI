class Expediente < ActiveRecord::Base

	attr_accessor :nombre_tipo, :nombre_afiliado

	belongs_to :tipo_de_expediente, :class_name => 'TipoDeExpediente'
	belongs_to :afiliado
	has_many :movimientos_de_mesa_de_entrada, :class_name => 'MovimientoDeMesaDeEntrada'

	cattr_reader :per_page
	@@per_page = 24

	def after_find
		self.nombre_tipo = self.tipo_de_expediente ? self.tipo_de_expediente.nombre : 'No hay tipo.'
		self.nombre_afiliado = self.afiliado ? self.afiliado.nombre : 'No hay afiliado.'
		self.fecha_de_apertura = fecha_de_apertura
		self.fecha_de_cierre = fecha_de_cierre
	end

	validate :fecha_de_apertura_valida
	validates_presence_of :nombre, :tipo_de_expediente, :message => "no puede estar vacio."

	def fecha_de_apertura_valida
		before = self.fecha_de_apertura_before_type_cast
		unless (before.nil? or before.class == Date)
			begin
				f = Date.strptime(before, '%d/%m/%Y')
			rescue
				errors.add(:fecha_de_apertura, 'invalida o vacía, debe ser formato "DD/MM/AAAA"')
			else
				self.fecha_de_apertura = f
			end
		end
	end

end
