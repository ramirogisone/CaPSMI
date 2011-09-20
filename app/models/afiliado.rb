class Afiliado < ActiveRecord::Base

	cattr_reader :per_page
	@@per_page = 24

	validates_presence_of :nombre, :message => "no puede estar vacio."

	def after_find
		self.cuit = cuit? ? cuit.round : 0
		self.documento = documento ? documento.round : 0
		self.nacimiento = self.nacimiento if self.nacimiento
		self.fallecimiento = self.fallecimiento if self.fallecimiento
		self.fecha_titulo = self.fecha_titulo if self.fecha_titulo
		self.fecha_matricula = self.fecha_matricula if self.fecha_matricula
		self.inicio_devengamiento = self.inicio_devengamiento if self.inicio_devengamiento
		self.final_devengamiento = self.final_devengamiento if self.final_devengamiento
		self.inicio_afiliacion = self.inicio_afiliacion if self.inicio_afiliacion
		self.fec_grab = self.fec_grab if self.fec_grab
	end

	validates_numericality_of :documento, :cuit, :message => "debe ser un numero."

	validate :valida_fechas

	def valida_fechas
		%w(nacimiento fallecimiento fecha_titulo fecha_matricula 
				inicio_devengamiento final_devengamiento inicio_afiliacion 
				fec_grab).each do |x|
			before = self.send("#{x}_before_type_cast")
			next if before.nil? or before.class == Date or before.empty? or
				self.send("#{x}").nil?
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
