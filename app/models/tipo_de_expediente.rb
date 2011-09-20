class TipoDeExpediente < ActiveRecord::Base

	set_table_name 'tipos_de_expedientes'
	
	has_many :expedientes
	has_many :rutas_predefinidas, :class_name => 'RutaPredefinida', :dependent => :delete_all

	cattr_reader :per_page
	@@per_page = 24
	
	validates_presence_of :posicion, :nombre, :message => "no puede estar vacio."
	validates_uniqueness_of :posicion, :message => "ya existe."
	
end
