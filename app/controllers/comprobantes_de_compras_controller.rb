class ComprobantesDeComprasController < ApplicationController

	before_filter :require_user
	before_filter :listas
	
	def listas
		@usuarios = User.all
		@proveedores = Proveedor.find(:all, :order => 'nombre')
	end

	# GET /comprobantes_de_compras
	# GET /comprobantes_de_compras.xml
	def index
		@comprobantes_de_compras = ComprobanteDeCompra.find(:all, :order => 'id DESC')
	
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @comprobantes_de_compras }
		end
	end

	# GET /comprobantes_de_compras/1
	# GET /comprobantes_de_compras/1.xml
	def show
		@comprobante_de_compra = ComprobanteDeCompra.find(params[:id])
	
		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @comprobante_de_compra }
		end
	end

	# GET /comprobantes_de_compras/new
	# GET /comprobantes_de_compras/new.xml
	def new
		@comprobante_de_compra = ComprobanteDeCompra.new(:user_id => current_user.id)
		@comprobante_de_compra.fecha = Date.today
		@comprobante_de_compra.total = 0.00
			
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @comprobante_de_compra }
		end
	end
	
	# GET /comprobantes_de_compras/1/edit
	def edit
		@comprobante_de_compra = ComprobanteDeCompra.find(params[:id])
	end
	
	# POST /comprobantes_de_compras
	# POST /comprobantes_de_compras.xml
	def create
		@comprobante_de_compra = ComprobanteDeCompra.new(params[:comprobante_de_compra])
	
		respond_to do |format|
			if @comprobante_de_compra.save
				linea = CuentaDeProveedor.new(
					:comprobante_de_compra_id => @comprobante_de_compra.id,
					:fecha => @comprobante_de_compra.fecha,
					:tipo => @comprobante_de_compra.tipo,
					:centro => @comprobante_de_compra.centro,
					:numero => @comprobante_de_compra.numero,
					:proveedor_id => @comprobante_de_compra.proveedor_id,
					:clase_valor => '',
					:lote_valor => 0,
					:numero_valor => 0,
					:fecha_valor => @comprobante_de_compra.fecha,
					:importe => @comprobante_de_compra.total,
					:tipo_aplicado => @comprobante_de_compra.tipo,
					:centro_aplicado => @comprobante_de_compra.centro,
					:numero_aplicado => @comprobante_de_compra.numero,
					:fecha_aplicado => @comprobante_de_compra.fecha,
					:vencimiento => @comprobante_de_compra.fecha,
					:detalle => @comprobante_de_compra.proveedor.nombre,
					:fec_grab => Date.today,
					:hor_grab => '',
					:wks_grab => '',
					:tip_grab => '',
					:usr_grab => '',
					:rec_grab => '')
				linea.save
				format.html { redirect_to(@comprobante_de_compra, :notice => 'ComprobanteDeCompra was successfully created.') }
				format.xml  { render :xml => @comprobante_de_compra, :status => :created, :location => @comprobante_de_compra }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @comprobante_de_compra.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	# PUT /comprobantes_de_compras/1
	# PUT /comprobantes_de_compras/1.xml
	def update
		@comprobante_de_compra = ComprobanteDeCompra.find(params[:id])
	
		respond_to do |format|
			params[:comprobante_de_compra][:user_id] = current_user.id
			if @comprobante_de_compra.update_attributes(params[:comprobante_de_compra])
				format.html { redirect_to(@comprobante_de_compra, :notice => 'ComprobanteDeCompra was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @comprobante_de_compra.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	# DELETE /comprobantes_de_compras/1
	# DELETE /comprobantes_de_compras/1.xml
	def destroy
		@comprobante_de_compra = ComprobanteDeCompra.find(params[:id])
		@comprobante_de_compra.destroy
	
		respond_to do |format|
			format.html { redirect_to(comprobantes_de_compras_url) }
			format.xml  { head :ok }
		end
	end

	def get_proveedor
		proveedor = Proveedor.find(params[:proveedor])
		@comprobante_de_compra = ComprobanteDeCompra.new(
			:user_id => current_user.id,
			:proveedor_id => proveedor.id,
			:domicilio => proveedor.domicilio,
			:ciudad => proveedor.ciudad,
			:codigo_postal => proveedor.codigo_postal,
			:provincia => proveedor.provincia,
			:telefonos => proveedor.telefonos,
			:regimen_iva => proveedor.regimen_iva,
			:total => '0.0')
		@comprobante_de_compra.fecha = Date.today
		render :partial => 'form', :locals => { :boton => 'Crear' }
	end

	def importar
		file = 'c:/prov_cab.dbf'
		ComprobanteDeCompra.delete_all
		DBF::Table.new(file).each do |r|
			if r
				cc = ComprobanteDeCompra.new

				cc.id = r.attributes["id"]
				cc.fecha = r.fecha
				cc.tipo = r.tipo.to_utf8
				cc.centro = r.centro
				cc.numero = r.numero
				cc.proveedor_id = r.link1

				cc.domicilio = r.domicilio.to_utf8
				cc.ciudad = r.ciudad.to_utf8
				cc.codigo_postal = r.cod_postal
				cc.regimen_iva = r.regimen
				cc.total = r.total

				cc.fec_grab = r.fec_grab
				cc.hor_grab = r.hor_grab
				cc.usr_grab = r.usr_grab
				cc.wks_grab = r.wks_grab
				cc.tip_grab = r.tip_grab

				cc.save
			end
		end
		redirect_to :action => 'index'
	end

	def imprimir
		@cabecera = ComprobanteDeCompra.find(params[:id])
		@lineas = [ [ 'Proveedor', 'Movimiento', 'Detalle', 'Importe',
			'Vto.', 'Valor', 'Aplicación' ] ]
		@cabecera.cuentas_de_proveedores.each do |linea|
			@lineas << [ "#{linea.proveedor_id} - #{linea.proveedor.nombre}", linea.movimiento,
				linea.detalle, linea.importe, linea.vencimiento, linea.valor, linea.aplicacion]
		end
		respond_to do |format|
			format.pdf
		end
	end

end
