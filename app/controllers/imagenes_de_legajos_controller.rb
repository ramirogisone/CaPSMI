class ImagenesDeLegajosController < ApplicationController

  before_filter :require_user
  before_filter :legajo

  def legajo
    @legajo = Legajo.find(params[:legajo_id]) if params[:legajo_id]
  end

  # GET /imagenes_de_legajos
  # GET /imagenes_de_legajos.xml
  def index
    @imagenes_de_legajos = @legajo.imagenes_de_legajos.paginate :page => params[:page], :order => 'id'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @imagenes_de_legajos }
    end
  end

  # GET /imagenes_de_legajos/1
  # GET /imagenes_de_legajos/1.xml
  def show
    @imagen_de_legajo = @legajo.imagenes_de_legajos.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @imagen_de_legajo }
    end
  end

  # GET /imagenes_de_legajos/new
  # GET /imagenes_de_legajos/new.xml
  def new
    @imagen_de_legajo = @legajo.imagenes_de_legajos.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @imagen_de_legajo }
    end
  end

  # GET /imagenes_de_legajos/1/edit
  def edit
    @imagen_de_legajo = @legajo.imagenes_de_legajos.find(params[:id])
  end

  # POST /imagenes_de_legajos
  # POST /imagenes_de_legajos.xml
  def create
    @imagen_de_legajo = @legajo.imagenes_de_legajos.build(params[:imagen_de_legajo])

    respond_to do |format|
      if @imagen_de_legajo.save
        format.html { redirect_to([@legajo,@imagen_de_legajo], :notice => 'ImagenDeLegajo was successfully created.') }
        #format.xml  { render :xml => ([@legajo,@imagen_de_legajo], :status => :created, :location => @imagen_de_legajo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @imagen_de_legajo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /imagenes_de_legajos/1
  # PUT /imagenes_de_legajos/1.xml
  def update
    @imagen_de_legajo = ImagenDeLegajo.find(params[:id])

    respond_to do |format|
      if @imagen_de_legajo.update_attributes(params[:imagen_de_legajo])
        format.html { redirect_to([@legajo,@imagen_de_legajo], :notice => 'ImagenDeLegajo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @imagen_de_legajo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /imagenes_de_legajos/1
  # DELETE /imagenes_de_legajos/1.xml
  def destroy
    @imagen_de_legajo = ImagenDeLegajo.find(params[:id])
    @imagen_de_legajo.destroy

    respond_to do |format|
      format.html { redirect_to(legajo_imagenes_de_legajos_url) }
      format.xml  { head :ok }
    end
  end

  def listar
    @imagenes_de_legajos = ImagenDeLegajo.paginate :page => params[:page], :order => 'id DESC'
  end

end
