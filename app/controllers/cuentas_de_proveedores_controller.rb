class CuentasDeProveedoresController < ApplicationController

	before_filter :require_user
	before_filter :comprobante_de_compra
	before_filter :listas

	def comprobante_de_compra
		@comprobante_de_compra = ComprobanteDeCompra.find(params[:comprobante_de_compra_id]) if params[:comprobante_de_compra_id]
	end

	def listas
		@proveedores = Proveedor.find(:all, :order => 'nombre')
	end

	def set_total
		@comprobante_de_compra.total =  @comprobante_de_compra.cuentas_de_proveedores.map{|l| l.importe}.sum 
		@comprobante_de_compra.save
	end

	def index
		@cuentas_de_proveedores = @comprobante_de_compra.cuentas_de_proveedores

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @cuentas_de_proveedores }
		end
	end

	def show
		@cuenta_de_proveedor = CuentaDeProveedor.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @cuenta_de_proveedor }
		end
	end

	def new
		@cuenta_de_proveedor = @comprobante_de_compra.cuentas_de_proveedores.build
		@cuenta_de_proveedor.proveedor_id = @comprobante_de_compra.proveedor_id
		@cuenta_de_proveedor.importe = '0.00'
		@cuenta_de_proveedor.vencimiento = Date.today

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @cuenta_de_proveedor }
		end
	end

	def edit
		@cuenta_de_proveedor = @comprobante_de_compra.cuentas_de_proveedores.find(params[:id])
	end

	def create
		@cuenta_de_proveedor = @comprobante_de_compra.cuentas_de_proveedores.build(params[:cuenta_de_proveedor])
	
		respond_to do |format|
			if @cuenta_de_proveedor.save
				set_total
				format.html { redirect_to([@comprobante_de_compra, @cuenta_de_proveedor],
					:notice => 'CuentaDeProveedor was successfully created.') }
				format.xml  { render :xml => @cuenta_de_proveedor, :status => :created,
					:location => @cuenta_de_proveedor }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @cuenta_de_proveedor.errors,
					:status => :unprocessable_entity }
			end
		end
	end

	def update
		@cuenta_de_proveedor = @comprobante_de_compra.cuentas_de_proveedores.find(params[:id])
	
		respond_to do |format|
			if @cuenta_de_proveedor.update_attributes(params[:cuenta_de_proveedor])
				set_total
				format.html { redirect_to([@comprobante_de_compra, @cuenta_de_proveedor], :notice => 'CuentaDeProveedor was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @cuenta_de_proveedor.errors, :status => :unprocessable_entity }
			end
		end
	end

	def destroy
		@cuenta_de_proveedor = CuentaDeProveedor.find(params[:id])
		@cuenta_de_proveedor.destroy
		set_total
		respond_to do |format|
			format.html { redirect_to(comprobante_de_compra_cuentas_de_proveedores_url) }
			format.xml  { head :ok }
		end
	end

	def listar
		@cuentas_de_proveedores = CuentaDeProveedor.paginate :page => params[:page], :order => 'id DESC'

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @cuentas_de_proveedores }
		end
	end

	def importar
		file = 'z:/prov_cta.dbf'
		CuentaDeProveedor.delete_all
		DBF::Table.new(file).each do |r|
			if r
				cp = CuentaDeProveedor.new

				cp.fecha = r.fecha
				cp.tipo = r.tipo.to_utf8
				cp.centro = r.centro
				cp.numero = r.numero
				cp.proveedor_id = r.cuenta

				cp.clase_valor = r.clase_val.to_utf8
				cp.lote_valor = r.lote_val
				cp.numero_valor = r.numero_val
				cp.fecha_valor = r.fecha_val

				cp.detalle = r.detalle.to_utf8
				cp.movimiento = r.movim.to_utf8
				cp.vencimiento = r.vencim
				cp.importe = r.importe

				cp.tipo_aplicado = r.tipo_ap.to_utf8
				cp.centro_aplicado = r.centro_ap
				cp.numero_aplicado = r.numero_ap
				cp.fecha_aplicado = r.fecha_ap

				cp.fec_grab = r.fec_grab
				cp.hor_grab = r.hor_grab.to_utf8
				cp.wks_grab = r.wks_grab.to_utf8
				cp.tip_grab = r.tip_grab.to_utf8
				cp.usr_grab = r.usr_grab.to_utf8
				cp.rec_grab = r.rec_grab

				cp.save
			end
		end
		redirect_to :action => 'index'
	end

	def consultar
		flash[:notice] = nil
		params[:formulario] = nil if params[:commit] == 'Cancelar'
		@form = Formulario.new(params[:formulario])
		case
			when (params[:commit] == 'Buscar' and @form.id.to_i == 0 and @form.nombre.empty?)
				flash[:notice] = 'Debe ingresar información.'
			when (params[:commit] == 'Buscar' and !@form.nombre.empty?)
				@form.id = 0
				condicion = []
				condicion << 'nombre LIKE ?'
				condicion << '%'+@form.nombre.upcase+'%'
				@resultado = Proveedor.find(:all, :conditions => condicion, :order => 'nombre')
				flash[:notice] = 'No se encuentran proveedores.' if @resultado.first.nil?
			when (params[:commit] == 'Buscar' and !@form.id.empty? and @form.id.to_i > 0)
				if @proveedor = Proveedor.find_by_id(@form.id)
					@form.id = @proveedor.id
					@form.nombre = @proveedor.nombre
				else
					flash[:notice] = 'No se encuentra proveedor.'
				end
			when params[:id]
				@proveedor = Proveedor.find(params[:id])
				@form.id = @proveedor.id
				@form.nombre = @proveedor.nombre
			when params[:commit] == 'Resumen de cuenta'
				@proveedor = Proveedor.find(@form.id)
				@form.id = @proveedor.id
				@form.nombre = @proveedor.nombre
				get_consulta
				session[:form_cuentas_de_proveedores] = @form
		end
	end

	def imprimir
		@form = session[:form_cuentas_de_proveedores]
		@proveedor = Proveedor.find(@form.id)
		get_consulta
		@lineas = [ [ 'Fecha', 'Identificación', 'Valor', 'Detalle',
			'Débito', 'Crédito', 'Saldo', 'Vto.', 'Aplicación' ] ]
		@consulta.each do |linea|
			@lineas << [ linea.fecha, linea.identificacion, linea.valor, linea.detalle,
				linea.debito, linea.credito, linea.saldo, linea.vencimiento, linea.aplicacion]
		end
		respond_to do |format|
			format.pdf
		end
	end

	def get_consulta
		saldo = 0.00
		fecha = ''
		@consulta = CuentaDeProveedor.find(:all, :conditions => ['proveedor_id = ?', @form.id.to_i],
				:order => 'fecha').each do |c|
			if fecha == c.fecha.to_s
				c.fecha = ''
			else
				fecha = c.fecha.to_s
			end
			if c.movimiento == 'D'
				c.debito = '%.2f' % c.importe
				c.credito = ''
				saldo = saldo + c.importe
			else
				c.debito = ''
				c.credito = '%.2f' % c.importe
				saldo = saldo - c.importe
			end
			c.saldo = '%.2f' % saldo
		end
	end

end
