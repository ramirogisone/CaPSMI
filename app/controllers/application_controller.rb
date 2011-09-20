# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

	helper :all # include all helpers, all the time
	protect_from_forgery # See ActionController::RequestForgeryProtection for details
	helper_method :current_user_session, :current_user
	filter_parameter_logging :password, :password_confirmation

	layout 'aplication'

	before_filter :get_panel

	def get_panel
		@sesion = UserSession.find
		sql = {}
		sql[:joins] = "LEFT OUTER JOIN links_users ON links.id = links_users.link_id"
		sql[:conditions] = []
		sql[:conditions] << "links.estado = 'Habilitada' AND links_users.id IS NULL"
		sql[:conditions][0] = sql[:conditions][0] +
			" OR links_users.user_id = #{@sesion.user.id}" if @sesion
		sql[:order] = 'links.posicion'
		@menu = Link.find(:all, sql)
		@usr_permiso = @sesion ? @sesion.user.id : 0
		if params[:opc_permiso]
			@opc_permiso = params[:opc_permiso].to_i
			session[:opc_permiso] = @opc_permiso
		else
			@opc_permiso = session[:opc_permiso] ? session[:opc_permiso].to_i : 0
		end
		#
		# Regimenes de IVA
		#
		@lista_de_regimenes =
			['1.Consumidor final',
			 '2.Resp.Inscripto',
			 '3.Resp.NO.inscripto',
			 '4.Monotributista',
			 '5.Exento']
	end

	private
		def current_user_session
			return @current_user_session if defined?(@current_user_session)
			@current_user_session = UserSession.find
		end

		def current_user
			return @current_user if defined?(@current_user)
			@current_user = current_user_session && current_user_session.record
		end

		def require_user
			unless current_user
				store_location
				flash[:notice] = 'Debe iniciar sesión.'
				redirect_to new_user_session_url
				return false
			end
		end

		def es_jorge
			unless current_user.id == 1
				store_location
				flash[:notice] = 'Debe ser administrador.'
				redirect_to new_user_session_url
			end
		end	

		def require_no_user
			if current_user
				store_location
				redirect_to new_user_session_url
				return false
			end
		end

		def store_location
			session[:return_to] = request.request_uri
		end

		def redirect_back_or_default(default = nil)
			if session[:return_to] or default or :back
				redirect_to(session[:return_to] || default || :back)
				session[:return_to] = nil
			end   
		end

end

class String
    def to_utf8
        ::Iconv.conv('UTF-8', 'cp437', self + ' ')[0..-2]
    end
end

class Float
	def to_letras
		valor = self || 0
		ret = ''
		#	Nombres de números
		unidades = ['', 'UN ', 'DOS ', 'TRES ', 'CUATRO ', 'CINCO ', 'SEIS ', 'SIETE ', 'OCHO ', 'NUEVE ']
		decenas = ['', 'DIEZ ', 'VEINTE ', 'TREINTA ', 'CUARENTA ', 'CINCUENTA ', 'SESENTA ', 'SETENTA ',
			'OCHENTA ', 'NOVENTA ']
		centenas = ['', 'CIENTO ', 'DOSCIENTOS ', 'TRESCIENTOS ', 'CUATROCIENTOS ', 'QUINIENTOS ',
			'SEISCIENTOS ', 'SETECIENTOS ', 'OCHOCIENTOS ', 'NOVECIENTOS ']
		especial = ['', '', '', '/CTVOS', '.-', '', '', '', '', '', '', 'ONCE ', 'DOCE ', 'TRECE ',
			'CATORCE ', 'QUINCE ', 'DIECISEIS ', 'DIECISIETE ', 'DIECIOCHO ', 'DIECINUEVE ', 'VEINTE ',
			'VEINTIUN ', 'VEINTIDOS ', 'VEINTITRES ', 'VEINTICUATRO ', 'VEINTICINCO ', 'VEINTISEIS ',
			'VEINTISIETE ', 'VEINTIOCHO ', 'VEINTINUEVE ']
		#	Valor a convertir
		if valor == 0
			ret = 'CERO' + especial[4]
		else
			fondo1 = 1000000000.00
			cvalor = sprintf('%13.2f', fondo1+valor)
			cvalor = cvalor[-12,12]
			ok = true
		end
		# Toma el primer grupo de tres digitos de la IZQUIERDA
		if ok
			reb = 0
			while reb < 9 and valor > 0
				triplo = cvalor[reb, 3]
				tre = triplo.to_i
				unless triplo == '000'
					dig1 = triplo[0, 1].to_i
					if dig1 > 0
						if triplo == '100'
							ret = ret + 'CIEN '
						else
							ret = ret + centenas[dig1]
						end
					end
					dig23 = triplo[1, 2].to_i
					dig3 = 0
					if dig23 > 0
						if dig23 >= 11 and dig23 <= 29
							ret = ret + especial[dig23]
						else
							dig2 = triplo[1,1].to_i
							if dig2 > 0
								ret = ret + decenas[dig2]
							end
							dig3 = triplo[2, 1].to_i
							if dig3 > 0
								if dig2 > 0
									ret = ret + 'Y ' + unidades[dig3]
								else
									ret = ret + unidades[dig3]
								end
							end
						end
					else
						if reb == 6
							ret = ret + ' '
						end
					end
					case reb
						when 0
							if tre == 1
								ret = ret + 'MILLON '
							else
								ret = ret + 'MILLONES '
							end
						when 3
							if tre > 0
								ret = ret + 'MIL '
							end
						when 6
							if dig3 == 1
								ret = ret[0, ret.length-1]
								ret = ret + 'O '
							end
					end
				end
				reb = reb + 3
			end
			cen = cvalor[10,2]
			unless cen == '00'
				ret = ret + 'CON ' + cen + especial[3]
			end
			ret = ret + especial[4]
		end
		ret
	end
end
