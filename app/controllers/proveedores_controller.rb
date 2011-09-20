class ProveedoresController < ApplicationController

	before_filter :require_user

	# GET /proveedores
	# GET /proveedores.xml
  def index
    @proveedores = Proveedor.paginate :page => params[:page], :order => 'id DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proveedores }
    end
  end

  # GET /proveedores/1
  # GET /proveedores/1.xml
  def show
    @proveedor = Proveedor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @proveedor }
    end
  end

  # GET /proveedores/new
  # GET /proveedores/new.xml
  def new
    @proveedor = Proveedor.new
    @proveedor.cuit = 0

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @proveedor }
    end
  end

  # GET /proveedores/1/edit
  def edit
    @proveedor = Proveedor.find(params[:id])
  end

  # POST /proveedores
  # POST /proveedores.xml
  def create
    @proveedor = Proveedor.new(params[:proveedor])

    respond_to do |format|
      if @proveedor.save
        format.html { redirect_to(@proveedor, :notice => 'Proveedor was successfully created.') }
        format.xml  { render :xml => @proveedor, :status => :created, :location => @proveedor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @proveedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /proveedores/1
  # PUT /proveedores/1.xml
  def update
    @proveedor = Proveedor.find(params[:id])

    respond_to do |format|
      if @proveedor.update_attributes(params[:proveedor])
        format.html { redirect_to(@proveedor, :notice => 'Proveedor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @proveedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /proveedores/1
  # DELETE /proveedores/1.xml
  def destroy
    @proveedor = Proveedor.find(params[:id])
    @proveedor.destroy

    respond_to do |format|
      format.html { redirect_to(proveedores_url) }
      format.xml  { head :ok }
    end
  end

  def index_full
    @proveedores = Proveedor.paginate :page => params[:page], :order => 'id'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @proveedores }
    end
  end

	def importar
		file = 'z:/prov_mae.dbf'
		Proveedor.delete_all
		DBF::Table.new(file).each do |r|
			if r
				p = Proveedor.new
	
				p.id = r.attributes["id"]
				p.nombre = r.nombre.to_utf8
				p.codigo_agrupacion = r.cod_agrup

				p.regimen_iva = r.regimen
				p.cuit = r.cui_fiscal
	
				p.domicilio = r.domicilio.to_utf8
				p.ciudad = r.ciudad.to_utf8
				p.codigo_postal = r.cod_postal
				p.provincia = r.provincia.to_utf8
				p.telefonos = r.telefonos
				p.fax = r.fax
				p.e_mail = r.e_mail
				p.area_geografica = r.area_geog

				p.observaciones = r.observ.to_s.to_utf8
	
				p.fec_grab = r.fec_grab
				p.hor_grab = r.hor_grab
				p.usr_grab = r.usr_grab
				p.wks_grab = r.wks_grab
				p.tip_grab = r.tip_grab
	
				p.save
			end
		end
		redirect_to :action => 'index'
	end

end
