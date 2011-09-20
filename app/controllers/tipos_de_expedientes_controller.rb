class TiposDeExpedientesController < ApplicationController
  
  before_filter :require_user
  
  # GET /tipos_de_expedientes
  # GET /tipos_de_expedientes.xml
  def index
    @tipos_de_expedientes = TipoDeExpediente.paginate :page => params[:page], :order => 'posicion'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tipos_de_expedientes }
    end
  end

  # GET /tipos_de_expedientes/1
  # GET /tipos_de_expedientes/1.xml
  def show
    @tipo_de_expediente = TipoDeExpediente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tipo_de_expediente }
    end
  end

  # GET /tipos_de_expedientes/new
  # GET /tipos_de_expedientes/new.xml
  def new
    @tipo_de_expediente = TipoDeExpediente.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tipo_de_expediente }
    end
  end

  # GET /tipos_de_expedientes/1/edit
  def edit
    @tipo_de_expediente = TipoDeExpediente.find(params[:id])
  end

  # POST /tipos_de_expedientes
  # POST /tipos_de_expedientes.xml
  def create
    @tipo_de_expediente = TipoDeExpediente.new(params[:tipo_de_expediente])

    respond_to do |format|
      if @tipo_de_expediente.save
        format.html { redirect_to(@tipo_de_expediente, :notice => 'TipoDeExpediente was successfully created.') }
        format.xml  { render :xml => @tipo_de_expediente, :status => :created, :location => @tipo_de_expediente }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tipo_de_expediente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tipos_de_expedientes/1
  # PUT /tipos_de_expedientes/1.xml
  def update
    @tipo_de_expediente = TipoDeExpediente.find(params[:id])

    respond_to do |format|
      if @tipo_de_expediente.update_attributes(params[:tipo_de_expediente])
        format.html { redirect_to(@tipo_de_expediente, :notice => 'TipoDeExpediente was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tipo_de_expediente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tipos_de_expedientes/1
  # DELETE /tipos_de_expedientes/1.xml
  def destroy
    @tipo_de_expediente = TipoDeExpediente.find(params[:id])
    @tipo_de_expediente.destroy

    respond_to do |format|
      format.html { redirect_to(tipos_de_expedientes_url) }
      format.xml  { head :ok }
    end
  end
end
