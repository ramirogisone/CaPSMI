class Legajo < ActiveRecord::Base

	attr_accessor :apellido_y_nombres

	cattr_reader :per_page
	@@per_page = 24
	
	has_many :imagenes_de_legajos, :class_name => 'ImagenDeLegajo', :dependent => :delete_all
	validates_presence_of :legajo, :apellido, :nombres, :message => "no puede estar vacio."
	validates_uniqueness_of :legajo, :message => "ya existe."

	def after_find
		# self.cuil = self.cuil? ? self.cuil.round : 0
		# self.documento = self.documento ? self.documento.round : 0
		# self.nacimiento = nacimiento
		# self.ingreso = self.ingreso if self.ingreso
		# self.egreso = self.egreso if self.egreso
	end

	validates_numericality_of :legajo, :documento, :cuil, :message => "debe ser un numero."

	validate :valida_fechas

	def valida_fechas
		%w(nacimiento ingreso egreso).each do |x|
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
	
	def apellido_y_nombres
		"#{self.apellido}, #{self.nombres}"
	end
	
end
