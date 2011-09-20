class ComprobanteDeCompra < ActiveRecord::Base

	belongs_to :proveedor
	belongs_to :user
	has_many :cuentas_de_proveedores, :class_name => 'CuentaDeProveedor', :dependent => :delete_all

	validate :fecha_valida
	validates_presence_of :fecha, :tipo, :proveedor_id, :user_id, :message => "no puede estar vacio."
	validates_numericality_of :total, :greater_than => 0, :message => "debe ser mayor a 0."

	def after_find
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
