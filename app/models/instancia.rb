class Instancia < ActiveRecord::Base

	cattr_reader :per_page
	@@per_page = 24

	has_many :rutas_predefinidas

	validates_presence_of :nombre, :message => "no puede estar vacio."

end

