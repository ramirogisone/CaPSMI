class ComprobanteDeMesaDeEntrada < ActiveRecord::Base

	attr_accessor :nombre_usuario
	
	belongs_to :user
	cattr_reader :per_page
	@@per_page = 24

	has_many :movimientos_de_mesa_de_entrada,
		:class_name => 'MovimientoDeMesaDeEntrada', :dependent => :delete_all
	validate :fecha_valida
	validates_presence_of :tipo, :user_id, :fecha, :message => "no puede estar vacio."

	def after_find
		self.nombre_usuario = self.user ? self.user.nombre : 'No hay usuario.'
		self.fecha = fecha
	end

	def fecha_valida
		if fecha_before_type_cast.class == Date or fecha_before_type_cast.to_s.empty?
		  return true
		end
		begin
		  f = Date.strptime(fecha_before_type_cast, '%d/%m/%Y')
		rescue
		  errors.add(:fecha, 'debe ser formato dd/mm/aaaa')
		  return false
		else
		  self.fecha = f
		end
	end

end
