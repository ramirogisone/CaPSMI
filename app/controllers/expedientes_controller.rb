class ExpedientesController < ApplicationController

  before_filter :require_user
  before_filter :listas, :except => [:index, :show, :destroy]
  
  def listas
    @tipos = TipoDeExpediente.find(:all, :order => 'posicion')
    @afiliados = Afiliado.find(:all, :order => 'nombre')
    #@afiliados = []
  end

  # GET /expedientes
  # GET /expedientes.xml
  def index
    @expedientes = Expediente.paginate :page => params[:page], :order => 'id DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expedientes }
    end
  end

  # GET /expedientes/1
  # GET /expedientes/1.xml
  def show
    @expediente = Expediente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expediente }
    end
  end

  # GET /expedientes/new
  # GET /expedientes/new.xml
  def new
    @expediente = Expediente.new
    @expediente.fecha_de_apertura = Date.today.to_s

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expediente }
    end
  end

  # GET /expedientes/1/edit
  def edit
    @expediente = Expediente.find(params[:id])
  end

  # POST /expedientes
  # POST /expedientes.xml
  def create
    @expediente = Expediente.new(params[:expediente])

    respond_to do |format|
      if @expediente.save
        format.html { redirect_to(@expediente, :notice => 'Expediente was successfully created.') }
        format.xml  { render :xml => @expediente, :status => :created, :location => @expediente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expediente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expedientes/1
  # PUT /expedientes/1.xml
  def update
    @expediente = Expediente.find(params[:id])

    respond_to do |format|
      if @expediente.update_attributes(params[:expediente])
        format.html { redirect_to(@expediente, :notice => 'Expediente was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expediente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expedientes/1
  # DELETE /expedientes/1.xml
  def destroy
    @expediente = Expediente.find(params[:id])
    @expediente.destroy

    respond_to do |format|
      format.html { redirect_to(expedientes_url) }
      format.xml  { head :ok }
    end
  end

end
