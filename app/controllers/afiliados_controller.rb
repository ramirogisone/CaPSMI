class AfiliadosController < ApplicationController

	before_filter :require_user

	# GET /afiliados
	# GET /afiliados.xml
	def index
		@afiliados = Afiliado.paginate :page => params[:page], :order => 'id'
	
		respond_to do |format|
		  format.html # index.html.erb
		  format.xml  { render :xml => @afiliados }
		end
    end
    
    # GET /afiliados/1
    # GET /afiliados/1.xml
    def show
		@afiliado = Afiliado.find(params[:id])
	
		respond_to do |format|
		  format.html # show.html.erb
		  format.xml  { render :xml => @afiliado }
		end
	end
    
	# GET /afiliados/new
	# GET /afiliados/new.xml
	def new
		@afiliado = Afiliado.new
	
		respond_to do |format|
		  format.html # new.html.erb
		  format.xml  { render :xml => @afiliado }
		end
	end
    
	# GET /afiliados/1/edit
	def edit
		@afiliado = Afiliado.find(params[:id])
	end
    
	# POST /afiliados
	# POST /afiliados.xml
	def create
		@afiliado = Afiliado.new(params[:afiliado])
	
		respond_to do |format|
		  if @afiliado.save
			format.html { redirect_to(@afiliado) }
			format.xml  { render :xml => @afiliado, :status => :created, :location => @afiliado }
		  else
			format.html { render :action => "new" }
			format.xml  { render :xml => @afiliado.errors, :status => :unprocessable_entity }
		  end
		end
	end
    
	# PUT /afiliados/1
	# PUT /afiliados/1.xml
	def update
		@afiliado = Afiliado.find(params[:id])
	
		respond_to do |format|
		  	if @afiliado.update_attributes(params[:afiliado])
				format.html { redirect_to(@afiliado) }
				format.xml  { head :ok }
		  	else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @afiliado.errors, :status => :unprocessable_entity }
		  	end
		end
	end
    
	# DELETE /afiliados/1
	# DELETE /afiliados/1.xml
	def destroy
		@afiliado = Afiliado.find(params[:id])
		@afiliado.destroy
	
		respond_to do |format|
			format.html { redirect_to(afiliados_url) }
			format.xml  { head :ok }
		end
	end
    
	def importar
		file = 'z:/nada/datos23/afil_mae.dbf'
		file = 'z:/afil_mae.dbf'
		file = 'c:/afil_mae.dbf'
    
		Afiliado.delete_all
    
		DBF::Table.new(file).each do |r|
			if r
				a = Afiliado.new

				a.id = r.attributes["id"]
				a.nombre = r.nombre.to_utf8

				a.nacimiento = r.nacimiento
				a.fallecimiento = r.ingres_lab
				a.lugar_nacimiento = r.lugarnacim.to_utf8
				a.tipo_documento = r.tipo_doc
				a.documento = r.documento
				a.estado_civil = r.est_civil
				a.sexo = r.sexo

				a.titulo = r.titulo.to_utf8
				a.universidad = r.universid.to_utf8
				a.fecha_titulo = r.fechatitu
				a.matricula = r.matricula
				a.fecha_matricula = r.fechamat
				a.colegio_profesional = r.colegiopro.to_utf8
				a.numero_colegio_profesional = r.aficolegio
				a.cuit = r.cui_fiscal
				a.regimen_iva = r.regimen

				a.inicio_devengamiento = r.ingres_leg
				a.final_devengamiento = r.egreso_leg
				a.inicio_afiliacion = r.inicio_act
				a.codigo_agrupacion = r.cod_agrup
				a.observaciones = r.observ.to_s.to_utf8

				a.domicilio_particular = r.domicilio.to_utf8
				a.ciudad_particular = r.ciudad.to_utf8
				a.codigo_postal_particular = r.cod_postal
				a.provincia_particular = r.provincia.to_utf8
				a.telefonos_particular = r.telefonos
				a.fax_particular = r.fax
				a.e_mail_particular = r.e_mail

				a.domicilio_profesional = r.domilab.to_utf8
				a.ciudad_profesional = r.ciudadlab.to_utf8
				a.codigo_postal_profesional = r.cpostlab
				a.provincia_profesional = r.provinlab.to_utf8
				a.telefonos_profesional = r.teleflab
				a.fax_profesional = r.faxlab
				a.e_mail_profesional = r.e_maillab
				a.area_geografica = r.area_geog

				a.fec_grab = r.fec_grab
				a.hor_grab = r.hor_grab
				a.usr_grab = r.usr_grab
				a.wks_grab = r.wks_grab
				a.tip_grab = r.tip_grab

				a.save
			end
		end
		redirect_to :action => 'index'
	end

	def buscar
		flash[:notice] = nil
		@form = Formulario.new(params[:formulario])
		@afiliados = []
		if params[:commit] == 'Buscar'
			condicion = []
			case
				when (@form.id_afiliado + @form.nombre_afiliado).empty?
					flash[:notice] = 'Debe ingresar informacion.'
				when !@form.id_afiliado.empty?
					condicion << 'id = ?'
					condicion << @form.id_afiliado.to_i
					@form.nombre_afiliado = ''
				when !@form.nombre_afiliado.empty?
					condicion << 'nombre LIKE ?'
					condicion << '%'+@form.nombre_afiliado.upcase+'%'
			end
			if condicion.first
				@afiliados = Afiliado.find(:all, :conditions => condicion, :order => 'nombre')
				flash[:notice] = 'No se encuentran afiliados.' if @afiliados.first.nil?
			end
		end
	end

	def listar
		flash[:notice] = nil
		@form = Formulario.new(params[:formulario])
		case params[:commit]
			when 'Cancelar'
				@form = Formulario.new
				session[:form] = nil
			when 'Listar'
				case
					when @form.profesion_medicos == '0' && @form.profesion_ingenieros == '0'
						flash[:notice] = 'Debe marcar profesión.'
					when @form.condicion_activos == '0' && @form.condicion_inactivos == '0'
						flash[:notice] = 'Debe marcar condición de afiliado.'
					when @form.datos_personales == '0' && @form.datos_profesionales == '0' &&
							@form.datos_afiliacion == '0' && @form.datos_domicilio == '0' &&
							@form.datos_direccion == '0' && @form.datos_auditoria == '0'
						flash[:notice] = 'Debe marcar datos a mostrar.'
					else
						params = []
						profesion = ''
						case
							when (@form.profesion_medicos == '1' and @form.profesion_ingenieros == '1')
							when @form.profesion_medicos == '1'
								profesion = 'codigo_agrupacion LIKE ?'
								params << '__M%'
							else
								profesion = 'codigo_agrupacion NOT LIKE ?'
								params << '__M%'
						end
						condicion = ''
						case
							when (@form.condicion_activos == '1' and @form.condicion_inactivos == '1')
							when @form.condicion_activos == '1'
								condicion = 'codigo_agrupacion NOT LIKE ?'
								params << '___X%'
							else
								condicion = 'codigo_agrupacion LIKE ?'
								params << '___X%'
						end
						
						condiciones = []
						case
							when !(profesion.empty? or condicion.empty?)
								condiciones << "#{profesion} AND #{condicion}"
							when !profesion.empty?
								condiciones << "#{profesion}"
							when !condicion.empty?
								condiciones << "#{condicion}"
							else
								condiciones << true
						end
						condiciones = condiciones.concat(params)
						
						header = []
						header << 'Id' << 'Nombre'
						header << 'Datos personales' if @form.datos_personales == '1'
						header << 'Datos profesionales' if @form.datos_profesionales == '1'
						header << 'Datos de afiliación' if @form.datos_afiliacion == '1'
						header << 'Domicilio particular' if @form.datos_domicilio == '1'
						header << 'Dirección profesional' if @form.datos_direccion == '1'
						header << 'Auditoría' if @form.datos_auditoria == '1'
						@afiliados = [header]
						Afiliado.find(:all, :conditions => condiciones, :order => 'nombre').each do |a|
							linea = []
							linea << a.id.to_i << a.nombre

							linea << "#{a.nacimiento} - #{a.fallecimiento} \n
								#{a.lugar_nacimiento} \n #{a.tipo_documento} - #{a.documento} \n
								#{a.sexo} - #{a.estado_civil}" if @form.datos_personales == '1'

							linea << "#{a.titulo} - #{a.universidad} \n #{a.fecha_titulo} - #{a.matricula} \n
								#{a.fecha_matricula} - #{a.colegio_profesional} \n #{a.numero_colegio_profesional} -
								#{a.cuit} - #{a.regimen_iva}" if @form.datos_profesionales == '1'

							linea << 'Datos de afiliación' if @form.datos_afiliacion == '1'
							linea << 'Domicilio particular' if @form.datos_domicilio == '1'
							linea << 'Direccion profesional' if @form.datos_direccion == '1'
							linea << 'Auditoría' if @form.datos_auditoria == '1'
							@afiliados << linea
						end
						respond_to do |format|
							format.pdf
						end
				end
		end
	end

end
