class CuentaDeProveedor < ActiveRecord::Base

	attr_accessor :debito, :credito, :saldo, :identificacion, :valor, :aplicacion

	cattr_reader :per_page
	@@per_page = 24
	
	belongs_to :comprobante_de_compra
	belongs_to :proveedor

	def initialize(*args)
		super(*args)
		if self.tipo
			self.movimiento = case self.tipo
				when 'AOP' then 'D'
				when 'FAC' then 'H'
				when 'FAP' then 'H'
				when 'HAB' then 'D'
				when 'OPA' then 'D'
				when 'PPE' then 'D'
				when 'REC' then 'D'
			end
		end
	end

	validate :vencimiento_valido
	validates_presence_of :proveedor_id, :importe, :message => "no puede estar vacio."
	validates_numericality_of :importe, :greater_than => 0, :message => "debe ser mayor a 0."

	def after_find
		self.vencimiento = vencimiento
		self.importe = '%.2f' % importe
		self.identificacion = "#{tipo}-#{centro}-#{numero}"
		self.fecha_valor = fecha_valor
		self.valor = "#{clase_valor}-#{lote_valor}-#{numero_valor}-#{fecha_valor}"
		self.aplicacion = "#{tipo_aplicado}-#{centro_aplicado}-#{numero_aplicado}-#{fecha_aplicado}"
	end

	def vencimiento_valido
		if vencimiento_before_type_cast.class == Date
		  return true
		end
		begin
		  f = Date.strptime(vencimiento_before_type_cast, '%d/%m/%Y')
		rescue
		  errors.add(:vencimiento, 'vacío o inválido. Debe ser formato dd/mm/aaaa')
		  return false
		else
		  self.vencimiento = f
		end
	end

end
