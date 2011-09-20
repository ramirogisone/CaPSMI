class User < ActiveRecord::Base

	has_many :users_links, :class_name => 'UserLink', :dependent => :delete_all

	acts_as_authentic do |c|
		c.validate_email_field = false
	end

	def login_nombre
		self.login + ' (' + self.nombre + ')'
	end

end
