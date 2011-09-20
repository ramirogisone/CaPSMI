class RutasPredefinidasController < ApplicationController

	before_filter :require_user
	before_filter :tipo_de_expediente
	before_filter :instancias

	def tipo_de_expediente
		if params[:tipo_de_expediente_id]
			@tipo_de_expediente = TipoDeExpediente.find(params[:tipo_de_expediente_id])
			session[:tipo_de_expediente_id] = @tipo_de_expediente.id
		else
			@tipo_de_expediente =
				session[:tipo_de_expediente_id] ? TipoDeExpediente.find(session[:tipo_de_expediente_id]) : nil
    end
		@tipo_de_expediente.rutas_predefinidas.sort! {|x,y| x.paso <=> y.paso} if @tipo_de_expediente
	end
  
	def instancias
		@instancias = Instancia.find(:all, :order => 'nombre')
	end

	# GET /rutas_predefinidas
	# GET /rutas_predefinidas.xml
	def index
		@rutas_predefinidas = @tipo_de_expediente.rutas_predefinidas.paginate :page => params[:page], :order => 'paso'

		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @rutas_predefinidas }
		end
	end

	# GET /rutas_predefinidas/1
	# GET /rutas_predefinidas/1.xml
	def show
		@ruta_predefinida = @tipo_de_expediente.rutas_predefinidas.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @ruta_predefinida }
		end
	end

	# GET /rutas_predefinidas/new
	# GET /rutas_predefinidas/new.xml
	def new
		ultimo = @tipo_de_expediente.rutas_predefinidas.max {|x,y| x.paso <=> y.paso}
		ultimo = ultimo.nil? ? 1 : ultimo.paso + 1
		@ruta_predefinida = @tipo_de_expediente.rutas_predefinidas.build(:paso => ultimo)

		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @ruta_predefinida }
		end
	end

	# GET /rutas_predefinidas/1/edit
	def edit
		@ruta_predefinida = @tipo_de_expediente.rutas_predefinidas.find(params[:id])
	end

	# POST /rutas_predefinidas
	# POST /rutas_predefinidas.xml
	def create
		@ruta_predefinida = @tipo_de_expediente.rutas_predefinidas.build(params[:ruta_predefinida])

		respond_to do |format|
			if @ruta_predefinida.save
				format.html { redirect_to([@tipo_de_expediente,@ruta_predefinida], :notice => 'RutaPredefinida was successfully created.') }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @ruta_predefinida.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /rutas_predefinidas/1
	# PUT /rutas_predefinidas/1.xml
	def update
		@ruta_predefinida = RutaPredefinida.find(params[:id])

		respond_to do |format|
			if @ruta_predefinida.update_attributes(params[:ruta_predefinida])
				format.html { redirect_to([@tipo_de_expediente,@ruta_predefinida], :notice => 'RutaPredefinida was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @ruta_predefinida.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /rutas_predefinidas/1
	# DELETE /rutas_predefinidas/1.xml
	def destroy
		@ruta_predefinida = RutaPredefinida.find(params[:id])
		@ruta_predefinida.destroy
		tipo_de_expediente
		@tipo_de_expediente.rutas_predefinidas.each_with_index do |rp, i|
			rp.paso = i + 1
			rp.save
		end

		respond_to do |format|
			format.html { redirect_to tipo_de_expediente_rutas_predefinidas_path(@tipo_de_expediente) }
			format.xml  { head :ok }
		end
	end

	def lista
		@rutas_predefinidas = RutaPredefinida.paginate :page => params[:page],
			:order => 'tipo_de_expediente_id, paso'
	end
    
	def mueve_arriba 
		@ruta_actual = RutaPredefinida.find(params[:ruta_id].to_i)
		indice = @tipo_de_expediente.rutas_predefinidas.index {|rp| rp == @ruta_actual}
		if indice > 0
			@ruta_anterior = @tipo_de_expediente.rutas_predefinidas[indice - 1]
			paso_anterior = @ruta_anterior.paso
			@ruta_anterior.paso = @ruta_actual.paso
			@ruta_actual.paso = paso_anterior
			@ruta_anterior.save(false)
			@ruta_actual.save(false)
		end
		redirect_to tipo_de_expediente_rutas_predefinidas_path(@tipo_de_expediente)
	end

	def mueve_abajo 
		@ruta_actual = RutaPredefinida.find(params[:ruta_id].to_i)
		indice = @tipo_de_expediente.rutas_predefinidas.index {|rp| rp == @ruta_actual}
		if indice + 1 < @tipo_de_expediente.rutas_predefinidas.length
			@ruta_posterior = @tipo_de_expediente.rutas_predefinidas[indice + 1]
			paso_posterior = @ruta_posterior.paso
			@ruta_posterior.paso = @ruta_actual.paso
			@ruta_actual.paso = paso_posterior
			@ruta_posterior.save(false)
			@ruta_actual.save(false)
		end
		redirect_to tipo_de_expediente_rutas_predefinidas_path(@tipo_de_expediente)
	end

end
