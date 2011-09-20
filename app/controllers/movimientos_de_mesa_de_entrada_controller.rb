class MovimientosDeMesaDeEntradaController < ApplicationController

	before_filter :require_user
	before_filter :comprobante_de_mesa_de_entrada
	before_filter :listas

	def comprobante_de_mesa_de_entrada
		@comprobante_de_mesa_de_entrada = ComprobanteDeMesaDeEntrada.find(params[:comprobante_de_mesa_de_entrada_id]) if params[:comprobante_de_mesa_de_entrada_id]
	end

	def listas
		@expedientes = Expediente.find(:all, :order => 'nombre')
		@instancias_origen = InstanciaOrigen.find(:all, :order => 'nombre')
		@instancias_destino = InstanciaDestino.find(:all, :order => 'nombre')
	end
  
	def index
		@movimientos_de_mesa_de_entrada = @comprobante_de_mesa_de_entrada.movimientos_de_mesa_de_entrada.paginate :page => params[:page], :order => 'id ASC'
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @movimientos_de_mesa_de_entrada }
		end
	end

	def show
		@movimiento_de_mesa_de_entrada = @comprobante_de_mesa_de_entrada.movimientos_de_mesa_de_entrada.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @movimiento_de_mesa_de_entrada }
		end
	end

	def new
		@movimiento_de_mesa_de_entrada =  @comprobante_de_mesa_de_entrada.movimientos_de_mesa_de_entrada.build(:tipo_comprobante => @comprobante_de_mesa_de_entrada.tipo )
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @movimiento_de_mesa_de_entrada }
		end
	end

	def edit
		@movimiento_de_mesa_de_entrada =  @comprobante_de_mesa_de_entrada.movimientos_de_mesa_de_entrada.find(params[:id])
	end

	def create
		@movimiento_de_mesa_de_entrada = @comprobante_de_mesa_de_entrada.movimientos_de_mesa_de_entrada.build(params[:movimiento_de_mesa_de_entrada])
		if @movimiento_de_mesa_de_entrada.tipo != 'Pase'
			@movimiento_de_mesa_de_entrada.instancia_destino_id = @movimiento_de_mesa_de_entrada.instancia_origen_id
		end
		respond_to do |format|
			if @movimiento_de_mesa_de_entrada.save
				format.html { redirect_to([@comprobante_de_mesa_de_entrada, @movimiento_de_mesa_de_entrada], :notice => 'MovimientoDeMesaDeEntrada was successfully created.') }
				format.xml  { render :xml => @movimiento_de_mesa_de_entrada, :status => :created, :location => @movimiento_de_mesa_de_entrada }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @movimiento_de_mesa_de_entrada.errors, :status => :unprocessable_entity }
			end
		end
	end

	def update
		@movimiento_de_mesa_de_entrada = MovimientoDeMesaDeEntrada.find(params[:id])
		if @movimiento_de_mesa_de_entrada.tipo != 'Pase'
			params[:movimiento_de_mesa_de_entrada][:instancia_destino_id] = params[:movimiento_de_mesa_de_entrada][:instancia_origen_id]
		end
		respond_to do |format|
			if @movimiento_de_mesa_de_entrada.update_attributes(params[:movimiento_de_mesa_de_entrada])
				format.html { redirect_to([@comprobante_de_mesa_de_entrada, @movimiento_de_mesa_de_entrada], :notice => 'MovimientoDeMesaDeEntrada was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @movimiento_de_mesa_de_entrada.errors, :status => :unprocessable_entity }
			end
		end
	end

	def destroy
		@movimiento_de_mesa_de_entrada = MovimientoDeMesaDeEntrada.find(params[:id])
		@movimiento_de_mesa_de_entrada.destroy
		respond_to do |format|
			format.html { redirect_to(comprobante_de_mesa_de_entrada_movimientos_de_mesa_de_entrada_url) }
			format.xml  { head :ok }
		end
	end

	def lista
		@movimientos_de_mesa_de_entrada = MovimientoDeMesaDeEntrada.paginate :page => params[:page],
			:order => 'id DESC'
	end
  
	def impulsa_expediente
		redirect_to expedientes_url if params[:commit] == 'Cancelar'
		flash[:notice] = nil
		@form = Formulario.new(params[:formulario])
		@form.dias_plazo = 30 unless params[:formulario]
		@instancias = Instancia.all
		session[:expediente_id] = params[:expediente_id] if params[:expediente_id]
		@expediente = Expediente.find(session[:expediente_id])
		@form.tipo_comprobante = @expediente.movimientos_de_mesa_de_entrada.empty? ? 'IME' : 'PAS' 
		@movimiento = MovimientoDeMesaDeEntrada.new(:tipo_comprobante => @form.tipo_comprobante).tipo
		case
			when params[:expediente_id]
				@form.instancia_origen_id = @form.instancia_destino_id = 1
				paso = 1
				unless @expediente.movimientos_de_mesa_de_entrada.empty?
					@expediente.movimientos_de_mesa_de_entrada.sort! do |x,y|
						x.comprobante_de_mesa_de_entrada.fecha <=> y.comprobante_de_mesa_de_entrada.fecha
					end
					@form.instancia_origen_id = @expediente.movimientos_de_mesa_de_entrada.last.instancia_destino_id
					paso = @expediente.movimientos_de_mesa_de_entrada.length + 1
				end
				unless @expediente.tipo_de_expediente.rutas_predefinidas.empty?
					if ruta = @expediente.tipo_de_expediente.rutas_predefinidas.select{|rp| rp.paso == paso}.first
						@form.instancia_destino_id = ruta.instancia_id
						@form.dias_plazo = ruta.dias_plazo
					end
				end
			when params[:commit] == 'Impulsar'
				case
					when @form.tipo_comprobante.empty?
						flash[:notice] = 'Debe ingresar tipo de comprobante.'
					when @form.instancia_origen_id == 0
						flash[:notice] = 'Debe ingresar instancia origen.'
					when (@movimiento == 'Pase' and @form.instancia_destino_id == 0)
						flash[:notice] = 'Debe ingresar instancia destino.'
					when (@movimiento == 'Pase' and @form.instancia_origen_id == @form.instancia_destino_id)
						flash[:notice] = 'Las instancias deben ser distintas.'
					when @form.dias_plazo < 1
						flash[:notice] = 'Días de plazo debe ser mayor a cero.'
					else
						comprobante = ComprobanteDeMesaDeEntrada.new(
							:tipo => @form.tipo_comprobante,
							:fecha => Date.today,
							:numero => 0,
							:user_id => current_user.id,
							:observaciones => 'Impulsado !')
						comprobante.save(false)
						movim = MovimientoDeMesaDeEntrada.new(
							:comprobante_de_mesa_de_entrada_id => comprobante.id,
							:expediente_id => @expediente.id,
							:instancia_origen_id => @form.instancia_origen_id,
							:instancia_destino_id => @movimiento == 'Pase' ?
								@form.instancia_destino_id : @form.instancia_origen_id,
							:tipo_comprobante => comprobante.tipo,
							:dias_plazo => @form.dias_plazo,
							:informe => @form.informe)
						movim.save(false)
						redirect_to expedientes_url
				end
		end
	end
  
	def consultar
		flash[:notice] = nil
		params[:formulario] = nil if params[:commit] == 'Cancelar'
		@form = Formulario.new(params[:formulario])
		@expediente = Expediente.find(@form.id) if params[:commit] == 'Buscar'
		case
			when params[:id]
				#	Entra con id desde lista de expedientes => '@lista'
				@expediente = Expediente.find(params[:id])
				@form.id = @expediente.id
				@form.nombre = @expediente.nombre
			when (params[:commit] == 'Consultar' and @form.id.to_i == 0 and @form.nombre.empty?)
				#	El formulario no tiene información
				flash[:notice] = 'Debe ingresar información sobre Id o Nombre del expediente.'
			when (params[:commit] == 'Consultar' and !@form.nombre.empty?)
				#	Entra con nombre de espediente para búsqueda
				@form.id = 0
				condicion = []
				condicion << 'nombre LIKE ?'
				condicion << '%'+@form.nombre.upcase+'%'
				@lista = Expediente.find(:all, :conditions => condicion, :order => 'nombre')
				flash[:notice] = 'No se encuentran expedientes.' if @lista.empty?
			when (params[:commit] == 'Consultar' and !@form.id.empty? and @form.id.to_i > 0)
				#	Entra con id para búsqueda
				if @expediente = Expediente.find_by_id(@form.id)
					@form.id = @expediente.id
					@form.nombre = @expediente.nombre
				else
					flash[:notice] = 'No se encuentra expediente.'
				end
			when (params[:commit] == 'Buscar' and !@form.fecha_desde.empty? and !@form.fecha_desde_to_date)
				#	Valida fecha inicical
				flash[:notice] = '"Fecha desde" incorrecta. debe ser DD/MM/AAAA.'
			when (params[:commit] == 'Buscar' and !@form.fecha_hasta.empty? and !@form.fecha_hasta_to_date)
				#	Valida fecha final
				flash[:notice] = '"Fecha hasta" incorrecta. debe ser DD/MM/AAAA.'
			when (params[:commit] == 'Buscar' and !@form.fecha_desde.empty? and !@form.fecha_hasta.empty? and @form.fecha_desde_to_date > @form.fecha_hasta_to_date )
				#	Valida período de fechas
				flash[:notice] = '"Fecha desde" debe ser menor que "Fecha hasta"'
			when (params[:commit] == 'Buscar')
				get_consulta
		end
	end

	def get_consulta
		if  !@expediente.movimientos_de_mesa_de_entrada.empty?
			@consulta = @expediente.movimientos_de_mesa_de_entrada.select do |x|
				case
					when (!@form.fecha_desde.empty? and !@form.fecha_hasta.empty?)
						x.comprobante_de_mesa_de_entrada.fecha >= @form.fecha_desde_to_date and
						x.comprobante_de_mesa_de_entrada.fecha <= @form.fecha_hasta_to_date
					when !@form.fecha_desde.empty?
						x.comprobante_de_mesa_de_entrada.fecha >= @form.fecha_desde_to_date
					when !@form.fecha_hasta.empty?
						x.comprobante_de_mesa_de_entrada.fecha <= @form.fecha_hasta_to_date
				else
					true
				end
			end
			if @consulta.empty?
				flash[:notice] = 'Expediente sin movimientos para el período.'
				return
			end
			@consulta = @consulta.sort {|x,y| x.comprobante_de_mesa_de_entrada.fecha <=> y.comprobante_de_mesa_de_entrada.fecha}
			entrada_anterior = pase_anterior = salida_anterior = ''
			@consulta.each do |linea|
				cadena = "#{linea.instancia_destino_id} - #{linea.instancia_destino.nombre}"
				case
					when linea.tipo == 'Entrada'
						entrada_anterior = linea.entrada = cadena if entrada_anterior != cadena
					when linea.tipo == 'Pase'
						pase_anterior = linea.pase = cadena if pase_anterior != cadena
					when linea.tipo == 'Salida'
						salida_anterior = linea.salida = cadena if salida_anterior != cadena
				end
			end
			session[:form_movimientos_de_mesa_de_entrada] = @form
		else
			flash[:notice] = 'Expediente sin movimientos.'
		end              
	end

	def imprimir
		@form = session[:form_movimientos_de_mesa_de_entrada]
		@expediente = Expediente.find(@form.id)
		get_consulta
		@lineas = [ [ 'Fecha', 'Identificación', 'Entrada', 'Pase', 'Salida', 'Tipo' ] ]
		@consulta.each do |linea|
			@lineas << [ linea.comprobante_de_mesa_de_entrada.fecha,
				"#{linea.comprobante_de_mesa_de_entrada.tipo} - #{linea.comprobante_de_mesa_de_entrada.numero}",
				linea.entrada, linea.pase, linea.salida, linea.tipo ]
		end
		respond_to do |format|
			format.pdf
		end
	end
	
	def consultar_por_fecha
		flash[:notice] = nil
		params[:formulario] = nil if params[:commit] == 'Cancelar'
		@form = Formulario.new(params[:formulario])
		
		case
			when (params[:commit] == 'Consultar' and !@form.fecha_hasta.empty? and !@form.fecha_hasta_to_date)
			#	Valida fecha final
				flash[:notice] = '"Fecha" incorrecta. debe ser DD/MM/AAAA.'
			when (params[:commit] == 'Consultar' and !@form.fecha_hasta.empty? 
				@expedientes = 
		end
	end

end

