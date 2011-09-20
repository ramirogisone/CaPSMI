class ImportacionesDeVencimientosController < ApplicationController

	before_filter :require_user

  # GET /importaciones_de_vencimientos
  # GET /importaciones_de_vencimientos.xml
  def index
    @importaciones_de_vencimientos =
			ImportacionDeVencimiento.paginate :page => params[:page], :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @importaciones_de_vencimientos }
    end
  end

  # GET /importaciones_de_vencimientos/1
  # GET /importaciones_de_vencimientos/1.xml
  def show
    @importacion_de_vencimiento = ImportacionDeVencimiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @importacion_de_vencimiento }
    end
  end

  # GET /importaciones_de_vencimientos/new
  # GET /importaciones_de_vencimientos/new.xml
  def new
    @importacion_de_vencimiento = ImportacionDeVencimiento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @importacion_de_vencimiento }
    end
  end

  # GET /importaciones_de_vencimientos/1/edit
  def edit
    @importacion_de_vencimiento = ImportacionDeVencimiento.find(params[:id])
  end

  # PUT /importaciones_de_vencimientos/1
  # PUT /importaciones_de_vencimientos/1.xml
  def update
    @importacion_de_vencimiento = ImportacionDeVencimiento.find(params[:id])

    respond_to do |format|
      if @importacion_de_vencimiento.update_attributes(params[:importacion_de_vencimiento])
        format.html { redirect_to(@importacion_de_vencimiento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @importacion_de_vencimiento.errors,
					:status => :unprocessable_entity }
      end
    end
  end

  # DELETE /importaciones_de_vencimientos/1
  # DELETE /importaciones_de_vencimientos/1.xml
  def destroy
    @importacion_de_vencimiento = ImportacionDeVencimiento.find(params[:id])
    @importacion_de_vencimiento.destroy

    respond_to do |format|
      format.html { redirect_to(importaciones_de_vencimientos_url) }
      format.xml  { head :ok }
    end
  end

	# POST /importaciones_de_vencimientos
	# POST /importaciones_de_vencimientos.xml
	def create
		require 'csv'
		@importacion_de_vencimiento = ImportacionDeVencimiento.new(params[:importacion_de_vencimiento])
		if @importacion_de_vencimiento.save
			#
			#	Proceso
			#
			#	Afiliado.delete_all
			#	Vencimiento.delete_all
			informe = ''
			ultima_linea = ''
			Net::HTTP.get_response(URI.parse(@importacion_de_vencimiento.archivo_csv.url)).body.each do |linea|
				l = CSV.parse_line(linea)
				ultima_linea = l[0]
				case l[1]
					when 'afiliado'
						if @afiliado = Afiliado.find_by_id(l[2].to_i)
							@afiliado.destroy
							informe = informe + "(#{l[2]}) actualizado. "
						else
							informe = informe + "(#{l[2]}) nuevo. "
						end
						@afiliado = Afiliado.new
						@afiliado.id = l[2].to_i
						@afiliado.nombre = l[3].to_utf8
						@afiliado.nacimiento = l[4].empty? ? nil : Date.strptime(l[4], '%d/%m/%Y')
						@afiliado.fallecimiento = l[5].empty? ? nil : Date.strptime(l[5], '%d/%m/%Y')
						@afiliado.lugar_nacimiento = l[6].to_utf8
						@afiliado.tipo_documento = l[7].to_utf8
						@afiliado.documento = l[8].empty? ? nil : l[8].to_f.round
						@afiliado.estado_civil = l[9].to_utf8
						@afiliado.titulo = l[10].to_utf8
						@afiliado.universidad = l[11].to_utf8
						@afiliado.fecha_titulo = l[12].empty? ? nil : Date.strptime(l[12], '%d/%m/%Y')
						@afiliado.matricula = l[13].to_utf8
						@afiliado.fecha_matricula = l[14].empty? ? nil : Date.strptime(l[14], '%d/%m/%Y')
						@afiliado.colegio_profesional = l[15].to_utf8
						@afiliado.numero_colegio_profesional = l[16].to_utf8
						@afiliado.cuit = l[17].empty? ? nil : l[17].to_f.round
						@afiliado.inicio_devengamiento = l[18].empty? ? nil : Date.strptime(l[18], '%d/%m/%Y')
						@afiliado.final_devengamiento = l[19].empty? ? nil : Date.strptime(l[19], '%d/%m/%Y')
						@afiliado.inicio_afiliacion = l[20].empty? ? nil : Date.strptime(l[20], '%d/%m/%Y')
						@afiliado.codigo_agrupacion = l[21].to_utf8
						@afiliado.sexo = l[22].to_utf8
						@afiliado.observaciones = l[23].to_utf8
						@afiliado.domicilio_particular = l[24].to_utf8
						@afiliado.ciudad_particular = l[25].to_utf8
						@afiliado.codigo_postal_particular = l[26].to_utf8
						@afiliado.provincia_particular = l[27].to_utf8
						@afiliado.telefonos_particular = l[28].to_utf8
						@afiliado.fax_particular = l[29].to_utf8
						@afiliado.e_mail_particular = l[30].to_utf8
						@afiliado.domicilio_profesional = l[31].to_utf8
						@afiliado.ciudad_profesional = l[32].to_utf8
						@afiliado.codigo_postal_profesional = l[33].to_utf8
						@afiliado.provincia_profesional = l[34].to_utf8
						@afiliado.telefonos_profesional = l[35].to_utf8
						@afiliado.fax_profesional = l[36].to_utf8
						@afiliado.e_mail_profesional = l[37].to_utf8
						@afiliado.regimen_iva = l[38].to_utf8
						@afiliado.area_geografica = l[39].to_utf8
						@afiliado.fec_grab = l[40].empty? ? nil : Date.strptime(l[40], '%d/%m/%Y')
						@afiliado.hor_grab = l[41].to_utf8.to_utf8
						@afiliado.usr_grab = l[42].to_utf8.to_utf8
						@afiliado.wks_grab = l[43].to_utf8.to_utf8
						@afiliado.tip_grab = l[44].to_utf8.to_utf8
						@afiliado.save
					when 'vencimiento'
						Vencimiento.create(
							:importacion_de_vencimiento_id => @importacion_de_vencimiento.id,
							:afiliado_id => @afiliado.id,
							:tipo => l[2],
							:tipo_comprobante => l[3],
							:centro_comprobante => l[4].to_i,
							:numero_comprobante => l[5].to_f,
							:fecha_comprobante => Date.strptime(l[6], '%d/%m/%Y'),
							:vencimiento => Date.strptime(l[7], '%d/%m/%Y'),
							:detalle => l[8].to_utf8,
							:importe => l[9].to_f)
					end
			end
			@importacion_de_vencimiento.informe = 'Ultima Linea ' + ultima_linea + ' ' + informe
			@importacion_de_vencimiento.save
			redirect_to(@importacion_de_vencimiento)
		else
			render :action => 'new'
		end
	end

end
