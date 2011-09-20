class Admin::LinksUsersController < ApplicationController

  before_filter :require_user
  before_filter :link
  before_filter :users

  def link
    @link = Link.find(params[:link_id]) if params[:link_id]
    flash[:notice] = nil
  end

  def users
    @users = User.find(:all)
  end

  # GET /links_users
  # GET /links_users.xml
  def index
    @relaciones = @link.links_users

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relaciones }
    end
  end

  # GET /links_users/1
  # GET /links_users/1.xml
  def show
    @relacion = LinkUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @relacion }
    end
  end

  # GET /links_users/new
  # GET /links_users/new.xml
  def new
    @relacion = @link.links_users.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @relacion }
    end
  end

  # GET /links_users/1/edit
  def edit
    @relacion = @link.links_users.find(params[:id])
  end

  # POST /links_users
  # POST /links_users.xml
  def create
    nuevo = LinkUser.new(params[:link_user])
    existe = @link.links_users.select {|r| r.user == nuevo.user}
    @relacion = @link.links_users.build(params[:link_user])
    unless existe.empty?
    	flash[:notice] = 'El usuario ya esta relacionado'
    	render :action => "new"
    else
    	if @relacion.save
    		redirect_to([:admin, @link, @relacion], :notice => 'Usuario asociado, creado.')
    	else
    		render :action => "new"
    	end
    end
   end

  # PUT /links_users/1
  # PUT /links_users/1.xml
  def update
    @relacion = @link.links_users.find(params[:id])

    respond_to do |format|
      if @relacion.update_attributes(params[:link_user])
        format.html { redirect_to([:admin, @link, @relacion], :notice => 'Usuario asociado, actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @relacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links_users/1
  # DELETE /links_users/1.xml
  def destroy
    @relacion = LinkUser.find(params[:id])
    @relacion.destroy

    respond_to do |format|
      format.html { redirect_to(admin_link_links_users_url) }
      format.xml  { head :ok }
    end
  end
end
