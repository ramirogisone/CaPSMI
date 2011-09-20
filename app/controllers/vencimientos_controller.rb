class VencimientosController < ApplicationController

	before_filter :require_user
	before_filter :listas, :except => [:index, :show, :destroy]
	
	def listas
		@afiliados = Afiliado.find(:all, :order => 'nombre' )
		@importaciones_de_vencimientos = ImportacionDeVencimiento.find(:all, :order => 'fecha DESC' )
	end

	# GET /vencimientos
	# GET /vencimientos.xml
	def index
		@vencimientos = Vencimiento.paginate :page => params[:page], :order => 'id DESC'
	
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @vencimientos }
		end
	end
	
	# GET /vencimientos/1
	# GET /vencimientos/1.xml
	def show
		@vencimiento = Vencimiento.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @vencimiento }
		end
	end
	
	# GET /vencimientos/new
	# GET /vencimientos/new.xml
	def new
		@vencimiento = Vencimiento.new
	
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @vencimiento }
		end
	end
	
	# GET /vencimientos/1/edit
	def edit
		@vencimiento = Vencimiento.find(params[:id])
	end
	
	# POST /vencimientos
	# POST /vencimientos.xml
	def create
		@vencimiento = Vencimiento.new(params[:vencimiento])
	
		respond_to do |format|
		  if @vencimiento.save
			format.html { redirect_to(@vencimiento) }
			format.xml  { render :xml => @vencimiento, :status => :created, :location => @vencimiento }
		  else
			format.html { render :action => "new" }
			format.xml  { render :xml => @vencimiento.errors, :status => :unprocessable_entity }
		  end
		end
	end
	
	# PUT /vencimientos/1
	# PUT /vencimientos/1.xml
	def update
		@vencimiento = Vencimiento.find(params[:id])
	
		respond_to do |format|
		  if @vencimiento.update_attributes(params[:vencimiento])
			format.html { redirect_to(@vencimiento) }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @vencimiento.errors, :status => :unprocessable_entity }
		  end
		end
	end
	
	# DELETE /vencimientos/1
	# DELETE /vencimientos/1.xml
	def destroy
		@vencimiento = Vencimiento.find(params[:id])
		@vencimiento.destroy
	
		respond_to do |format|
		  format.html { redirect_to(vencimientos_url) }
		  format.xml  { head :ok }
		end
	end

end
