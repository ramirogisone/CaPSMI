class BoletasController < ApplicationController

	before_filter :require_user, :only => [:index, :destroy]

	def index
		@boletas = Boleta.paginate :page => params[:page], :order => 'id DESC'
	end

	# DELETE /boletas/1
	# DELETE /boletas/1.xml
	def destroy
		@boleta = Boleta.find(params[:id])
		@boleta.destroy

		respond_to do |format|
			format.html { redirect_to(boletas_url) }
			format.xml  { head :ok }
		end
	end

	def consultar
		@boleta = Boleta.find(params[:boleta_id])
	end

	def buscar
		flash[:notice] = nil
		@form = Formulario.new(params[:formulario])
		case params[:commit]
			when 'Cancelar'
				@form = Formulario.new
				session[:form] = nil
			when 'Buscar'
				case
					when (@form.documento_afiliado + @form.nacimiento_afiliado +
							@form.id_afiliado).empty?
						flash[:notice] = 'Debe ingresar informacion.'
					when @form.deuda_previsional == '0' && @form.deuda_financiacion == '0' && 
							@form.deuda_prestamo == '0'
						flash[:notice] = 'Debe marcar tipo de deuda.'
					when !@form.id_afiliado.empty?
						unless @afiliado = Afiliado.find_by_id(@form.id_afiliado.to_i)
							flash[:notice] = 'No se encuentra el afiliado.'
						end
					when @form.documento_afiliado.empty?
						flash[:notice] = 'Debe ingresar documento.'
					when @form.nacimiento_afiliado.empty?
						flash[:notice] = 'Debe ingresar fecha de nacimiento.'
					when (not nacimiento = @form.nacimiento_to_date)
						flash[:notice] = 'fecha de nacimiento incorrecta. debe ser DD/MM/AAAA.'
					else
						unless @afiliado = Afiliado.find_by_documento_and_nacimiento(
								@form.documento_afiliado.to_f, nacimiento)
							flash[:notice] = 'No se encuentra el afiliado.'
						end
				end
				if @afiliado
					@form.documento_afiliado = @afiliado.documento.round
					@form.nacimiento_afiliado = @afiliado.nacimiento
					@form.id_afiliado = @afiliado.id
					@form.nombre_afiliado = @afiliado.nombre
					@form.id_importacion = 0
					@form.datos_importacion = ''
					if ultima = Vencimiento.maximum(:importacion_de_vencimiento_id,
							:conditions => ['afiliado_id = ?', @afiliado.id])
						ultima = ImportacionDeVencimiento.find(ultima)
						@form.id_importacion = ultima.id
						@form.datos_importacion = "#{ultima.fecha} #{ultima.id}"
						deuda = ''
						deuda = deuda + "tipo = 'Previsional'" if @form.deuda_previsional == '1'
						deuda = deuda + (deuda.empty? ? '' : ' OR ') +
							"tipo = 'Financiacion'" if @form.deuda_financiacion == '1'
						deuda = deuda + (deuda.empty? ? '' : ' OR ') +
							"tipo = 'Prestamo'" if @form.deuda_prestamo == '1'
						where = 'afiliado_id = ? AND importacion_de_vencimiento_id = ? AND '
						where = where + '(' + deuda + ')'
						@form.where = where
						@vencimientos = Vencimiento.find(:all,
							:conditions => [where, @afiliado.id, ultima.id])
						@total = @vencimientos.map { |v| v.importe }.sum
					end
					flash[:notice] = 'No hay vencimientos.' unless @vencimientos and @vencimientos.first
					session[:form_boletas] = @form
				end
		end
	end

	def imprimir
		@form = session[:form_boletas]
		@afiliado = Afiliado.find_by_id(@form.id_afiliado.to_i)
		#
		@boleta = Boleta.new(:afiliado_id => @afiliado.id)
		#
		@total = 0.00
		@vencimientos = [ [ 'Detalle', 'Importe' ] ]
		Vencimiento.find(:all, :conditions => [@form.where, @afiliado.id, @form.id_importacion],
				:order => 'vencimiento').each do |v|
			detalle = "#{v.detalle} \n Cpbte.: #{v.comprobante} \n Deuda: #{v.tipo}"
	  		@vencimientos << [ detalle, '%.2f' % v.importe ]
			@total = @total + v.importe
			#
			@boleta.vencimiento = v.vencimiento
			@boleta.vencimientos << v
			#
		end
		@vencimientos << [ 'Total a pagar :', '$'+ ('%.2f' % @total) ]
		#
		@boleta.total = @total
		@boleta.save
		#
		respond_to do |format|
			format.pdf
		end
	end

end
