class InstanciasController < ApplicationController

  before_filter :require_user

  # GET /instancias
  # GET /instancias.xml
  def index
    @instancias = Instancia.paginate :page => params[:page], :order => 'id'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @instancias }
    end
  end

  # GET /instancias/1
  # GET /instancias/1.xml
  def show
    @instancia = Instancia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @instancia }
    end
  end

  # GET /instancias/new
  # GET /instancias/new.xml
  def new
    @instancia = Instancia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @instancia }
    end
  end

  # GET /instancias/1/edit
  def edit
    @instancia = Instancia.find(params[:id])
  end

  # POST /instancias
  # POST /instancias.xml
  def create
    @instancia = Instancia.new(params[:instancia])

    respond_to do |format|
      if @instancia.save
        format.html { redirect_to(@instancia, :notice => 'Instancia was successfully created.') }
        format.xml  { render :xml => @instancia, :status => :created, :location => @instancia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @instancia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /instancias/1
  # PUT /instancias/1.xml
  def update
    @instancia = Instancia.find(params[:id])

    respond_to do |format|
      if @instancia.update_attributes(params[:instancia])
        format.html { redirect_to(@instancia, :notice => 'Instancia was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @instancia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /instancias/1
  # DELETE /instancias/1.xml
  def destroy
    @instancia = Instancia.find(params[:id])
    @instancia.destroy

    respond_to do |format|
      format.html { redirect_to(instancias_url) }
      format.xml  { head :ok }
    end
  end
end
