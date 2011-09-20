# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def aviso
		if notice
			"<div id='flash-error'>#{notice}</div><br /><br /><br />"
		end
	end

	def permiso?(operacion)
		relacion = LinkUser.find_by_link_id_and_user_id(@opc_permiso, @usr_permiso)
		if relacion
			((operacion == 'A' and relacion.alta) or (operacion == 'B' and relacion.baja) or
				(operacion == 'M' and relacion.modificacion)) ? nil : 'off'
		else
			nil
		end
	end

end
