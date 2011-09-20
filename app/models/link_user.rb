class LinkUser < ActiveRecord::Base

	attr_accessor :nombre_user, :nombre_link

	belongs_to :link
	belongs_to :user

  validates_presence_of :user_id, :link_id, :message => 'no puede estar vacio.'

  def after_find
    self.nombre_user = self.user ? self.user.nombre : 'No hay usuario.'
    self.nombre_link = self.link ? self.link.nombre : 'No hay link.'
  end  

end
