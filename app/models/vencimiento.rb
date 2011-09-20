class Vencimiento < ActiveRecord::Base

	cattr_reader :per_page
	@@per_page = 24
    
	belongs_to :afiliado
	belongs_to :importacion_de_vencimiento
	has_and_belongs_to_many :boletas

	attr_accessor :nombre_afiliado, :datos_importacion, :comprobante
    
	def after_initialize
		self.importe = ('%.2f' % importe)
		self.numero_comprobante = numero_comprobante.round
	end

	def after_find
		self.nombre_afiliado = self.afiliado ? self.afiliado.nombre : 'No hay afiliado'
		i = self.importacion_de_vencimiento
		self.datos_importacion = i.fecha.to_s+' '+i.id.to_s if i
		self.numero_comprobante = numero_comprobante.round 
		self.fecha_comprobante = fecha_comprobante
		self.vencimiento = vencimiento
		self.comprobante = "#{tipo_comprobante}-#{centro_comprobante}-#{numero_comprobante.round}-#{fecha_comprobante}"
	end

	validate :valida_fechas
	validates_presence_of :importacion_de_vencimiento, :afiliado_id, :vencimiento,
		:importe, :message => "no puede estar vacio."
	validates_numericality_of :centro_comprobante, :numero_comprobante,
		:message => "debe ser un numero."
	validates_numericality_of :importe, :greater_than => 0, :message => "debe ser mayor a 0."

	def valida_fechas
		%w(fecha_comprobante vencimiento).each do |x|
			before = self.send("#{x}_before_type_cast")
			next if before.nil? or before.class == Date or before.empty?
			begin
				f = Date.strptime(before, '%d/%m/%Y')
			rescue
				errors.add("#{x}".to_sym, 'invalida, debe ser formato "DD/MM/AAAA"')
				return false
			else
				self.send("#{x}=", f)
				true
			end
		end
	end

end
