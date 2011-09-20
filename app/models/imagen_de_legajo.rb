class ImagenDeLegajo < ActiveRecord::Base

	attr_accessor :nombre_legajo

	belongs_to :legajo

	cattr_reader :per_page
	@@per_page = 24

	def after_find
		self.nombre_legajo = self.legajo.apellido+', '+self.legajo.nombres if self.legajo
	end

	validates_presence_of :legajo_id, :tipo, :nombre, :message => "no puede estar vacio."

	has_attached_file :imagen,
		:storage => :s3,
		:s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
		:path => "/capsmi/imagenes_de_legajos/:id/:basename.:extension"

end
