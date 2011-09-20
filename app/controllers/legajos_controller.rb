class LegajosController < ApplicationController

  before_filter :require_user

  # GET /legajos
  # GET /legajos.xml
  def index
    @legajos = Legajo.paginate :page => params[:page], :order => 'id'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @legajos }
    end
  end

  # GET /legajos/1
  # GET /legajos/1.xml
  def show
    @legajo = Legajo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @legajo }
    end
  end

  # GET /legajos/new
  # GET /legajos/new.xml
  def new
    @legajo = Legajo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @legajo }
    end
  end

  # GET /legajos/1/edit
  def edit
    @legajo = Legajo.find(params[:id])
  end

  # POST /legajos
  # POST /legajos.xml
  def create
    @legajo = Legajo.new(params[:legajo])

    respond_to do |format|
      if @legajo.save
        format.html { redirect_to(@legajo, :notice => 'Legajo was successfully created.') }
        format.xml  { render :xml => @legajo, :status => :created, :location => @legajo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @legajo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /legajos/1
  # PUT /legajos/1.xml
  def update
    @legajo = Legajo.find(params[:id])

    respond_to do |format|
      if @legajo.update_attributes(params[:legajo])
        format.html { redirect_to(@legajo, :notice => 'Legajo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @legajo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /legajos/1
  # DELETE /legajos/1.xml
  def destroy
    @legajo = Legajo.find(params[:id])
    @legajo.destroy

    respond_to do |format|
      format.html { redirect_to(legajos_url) }
      format.xml  { head :ok }
    end
  end

end
