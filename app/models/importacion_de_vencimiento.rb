class ImportacionDeVencimiento < ActiveRecord::Base

	validate :fecha_valida
	validates_presence_of :fecha, :message => "no puede estar vacio."
	validates_attachment_presence :archivo_csv
	
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

	has_attached_file :archivo_csv,
		:storage => :s3,
		:s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
		:path => "/capsmi/importaciones_de_vencimientos/:id/:basename.:extension"

end
