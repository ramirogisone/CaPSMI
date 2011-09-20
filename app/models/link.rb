class Link < ActiveRecord::Base

	validates_presence_of :posicion, :nombre, :message => "no puede estar vacio."
	validates_uniqueness_of :posicion, :message => "ya existe."
	has_many :links_users, :class_name => 'LinkUser', :dependent => :delete_all

end
