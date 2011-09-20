class ComprobantesDeMesaDeEntradaController < ApplicationController

	before_filter :require_user
  before_filter :usuarios

  def usuarios
    @usuarios = User.all
  end
  	
  # GET /comprobantes_de_mesa_de_entrada
  # GET /comprobantes_de_mesa_de_entrada.xml
  def index
    @comprobantes_de_mesa_de_entrada = ComprobanteDeMesaDeEntrada.paginate :page => params[:page], :order => 'id DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comprobantes_de_mesa_de_entrada }
    end
  end

  # GET /comprobantes_de_mesa_de_entrada/1
  # GET /comprobantes_de_mesa_de_entrada/1.xml
  def show
    @comprobante_de_mesa_de_entrada = ComprobanteDeMesaDeEntrada.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comprobante_de_mesa_de_entrada }
    end
  end

  # GET /comprobantes_de_mesa_de_entrada/new
  # GET /comprobantes_de_mesa_de_entrada/new.xml
  def new
    @comprobante_de_mesa_de_entrada = ComprobanteDeMesaDeEntrada.new(:user_id => current_user.id)
    @comprobante_de_mesa_de_entrada.fecha = Date.today
    @comprobante_de_mesa_de_entrada.numero = 0

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comprobante_de_mesa_de_entrada }
    end
  end

  # GET /comprobantes_de_mesa_de_entrada/1/edit
  def edit
    @comprobante_de_mesa_de_entrada = ComprobanteDeMesaDeEntrada.find(params[:id])
  end

  # POST /comprobantes_de_mesa_de_entrada
  # POST /comprobantes_de_mesa_de_entrada.xml
  def create
    @comprobante_de_mesa_de_entrada = ComprobanteDeMesaDeEntrada.new(params[:comprobante_de_mesa_de_entrada])

    respond_to do |format|
      if @comprobante_de_mesa_de_entrada.save
        format.html { redirect_to(@comprobante_de_mesa_de_entrada, :notice => 'ComprobanteDeMesaDeEntrada was successfully created.') }
        format.xml  { render :xml => @comprobante_de_mesa_de_entrada, :status => :created, :location => @comprobante_de_mesa_de_entrada }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comprobante_de_mesa_de_entrada.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comprobantes_de_mesa_de_entrada/1
  # PUT /comprobantes_de_mesa_de_entrada/1.xml
  def update
    @comprobante_de_mesa_de_entrada = ComprobanteDeMesaDeEntrada.find(params[:id])

    respond_to do |format|
      if @comprobante_de_mesa_de_entrada.update_attributes(params[:comprobante_de_mesa_de_entrada])
        format.html { redirect_to(@comprobante_de_mesa_de_entrada, :notice => 'ComprobanteDeMesaDeEntrada was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comprobante_de_mesa_de_entrada.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comprobantes_de_mesa_de_entrada/1
  # DELETE /comprobantes_de_mesa_de_entrada/1.xml
  def destroy
    @comprobante_de_mesa_de_entrada = ComprobanteDeMesaDeEntrada.find(params[:id])
    @comprobante_de_mesa_de_entrada.destroy

    respond_to do |format|
      format.html { redirect_to(comprobantes_de_mesa_de_entrada_url) }
      format.xml  { head :ok }
    end
  end

	def imprimir
		@cabecera = ComprobanteDeMesaDeEntrada.find(params[:id])
    @usuario = @cabecera.user.login_nombre
    pase = (MovimientoDeMesaDeEntrada.new(:tipo_comprobante => @cabecera.tipo).tipo == 'Pase')
		@lineas = [ [ 'Expediente', 'Instancia(s)', 'Tipo', 'Plazo', 'Informe' ]]
		@cabecera.movimientos_de_mesa_de_entrada.each do |linea|
			@lineas << [
				"#{linea.expediente_id} - #{linea.expediente.nombre}",
				pase ? "Origen:\n#{linea.instancia_origen_id} - #{linea.instancia_origen.nombre}
				  Destino:\n#{linea.instancia_destino_id} - #{linea.instancia_destino.nombre}" :
            "#{linea.instancia_origen_id} - #{linea.instancia_origen.nombre}",
				linea.tipo, linea.dias_plazo, linea.informe ]
		end
		respond_to do |format|
			format.pdf
		end
	end

end
