class Admin::LinksController < ApplicationController

	before_filter :require_user
	before_filter :listas
  
	def listas
		@lista_de_estados = ['Habilitada', 'Inhabilitada']
	end

	# GET /links
	# GET /links.xml
	def index
		@links = Link.find(:all, :order => 'posicion')

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @links }
		end
	end

	# GET /links/1
	# GET /links/1.xml
	def show
		@link = Link.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @link }
		end
	end

	# GET /links/new
	# GET /links/new.xml
	def new
		@link = Link.new

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @link }
		end
	end

	# GET /links/1/edit
	def edit
		@link = Link.find(params[:id])
	end

	# POST /links
	# POST /links.xml
	def create
		@link = Link.new(params[:link])

		respond_to do |format|
			if @link.save
				format.html { redirect_to( [:admin, @link] ) }
				format.xml  { render :xml => @link, :status => :created, :location => @link }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /links/1
	# PUT /links/1.xml
	def update
		@link = Link.find(params[:id])

		respond_to do |format|
			if @link.update_attributes(params[:link])
				format.html { redirect_to( [:admin, @link] ) }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /links/1
	# DELETE /links/1.xml
	def destroy
		@link = Link.find(params[:id])
		@link.destroy

		respond_to do |format|
			format.html { redirect_to(admin_links_url) }
			format.xml  { head :ok }
		end
	end

end
