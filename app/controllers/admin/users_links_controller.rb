class Admin::UsersLinksController < ApplicationController

	before_filter :require_user
  before_filter :user
  before_filter :links

  def user
    @user = User.find(params[:user_id]) if params[:user_id]
    flash[:notice] = nil
  end

  def links
    @links = Link.find(:all, :order => 'posicion')
  end

  def index
    @relaciones = @user.users_links

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @relaciones }
    end
  end

  def show
    @relacion = UserLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @relacion }
    end
  end

  def new
    @relacion = @user.users_links.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @relacion }
    end
  end

  def edit
    @relacion = @user.users_links.find(params[:id])
  end

  def create
    nuevo = UserLink.new(params[:user_link])
    existe = @user.users_links.select {|r| r.link == nuevo.link}
    @relacion = @user.users_links.build(params[:user_link])
    unless existe.empty?
    	flash[:notice] = 'El link ya esta relacionado'
    	render :action => "new"
    else
    	if @relacion.save
    		redirect_to([:admin, @user, @relacion], :notice => 'Link asociado, creado.')
    	else
    		render :action => "new"
    	end
    end
   end

  def update
    @relacion = @user.users_links.find(params[:id])

    respond_to do |format|
      if @relacion.update_attributes(params[:user_link])
        format.html { redirect_to([:admin, @user, @relacion], :notice => 'Link asociado, actualizado.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @relacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @relacion = UserLink.find(params[:id])
    @relacion.destroy

    respond_to do |format|
      format.html { redirect_to(admin_user_users_links_url) }
      format.xml  { head :ok }
    end
  end
end
