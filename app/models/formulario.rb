class Formulario

	attr_accessor :documento_afiliado, :nacimiento_afiliado, :id_afiliado, :nombre_afiliado,
		:id_importacion, :datos_importacion,
		:deuda_previsional, :deuda_financiacion, :deuda_prestamo, :where,
		:profesion_medicos, :profesion_ingenieros, :condicion_activos, :condicion_inactivos,
			:datos_personales, :datos_profesionales, :datos_afiliacion, :datos_domicilio,
			:datos_direccion, :datos_auditoria,
		:instancia_origen_id, :instancia_destino_id,
		:id, :nombre, :tipo_comprobante, :informe, :dias_plazo, :fecha_desde, :fecha_hasta, :vencidos

	def initialize(hash = {})
		self.deuda_previsional = '1'
		self.deuda_financiacion = '1'
		self.deuda_prestamo = '1'
		self.profesion_medicos = '1'
		self.profesion_ingenieros = '1'
		self.condicion_activos = '1'
		self.condicion_inactivos = '1'
		self.datos_personales = '1'
		self.datos_profesionales = '1'
		self.datos_afiliacion = '1'
		self.datos_domicilio = '1'
		self.datos_direccion = '1'
		self.datos_auditoria = '1'
		self.id = 0
		if hash and hash.length > 0
			self.documento_afiliado = hash[:documento_afiliado]
			self.nacimiento_afiliado = hash[:nacimiento_afiliado]
			self.id_afiliado = hash[:id_afiliado]
			self.nombre_afiliado = hash[:nombre_afiliado]
			self.id_importacion = hash[:id_importacion]
			self.datos_importacion = hash[:datos_importacion]
			self.deuda_previsional = hash[:deuda_previsional]
			self.deuda_financiacion = hash[:deuda_financiacion]
			self.deuda_prestamo = hash[:deuda_prestamo]
			self.where = hash[:where]

			self.profesion_medicos = hash[:profesion_medicos]
			self.profesion_ingenieros = hash[:profesion_ingenieros]
			self.condicion_activos = hash[:condicion_activos]
			self.condicion_inactivos = hash[:condicion_inactivos]
			self.datos_personales = hash[:datos_personales]
			self.datos_profesionales = hash[:datos_profesionales]
			self.datos_afiliacion = hash[:datos_afiliacion]
			self.datos_domicilio = hash[:datos_domicilio]
			self.datos_direccion = hash[:datos_direccion]
			self.datos_auditoria = hash[:datos_auditoria]
			
			self.instancia_origen_id = hash[:instancia_origen_id].to_i
			self.instancia_destino_id = hash[:instancia_destino_id].to_i

			self.id = hash[:id]
			self.nombre = hash[:nombre]
			self.tipo_comprobante = hash[:tipo_comprobante]
			self.informe = hash[:informe]
			self.dias_plazo = hash[:dias_plazo].to_i
			self.fecha_desde = hash[:fecha_desde]
			self.fecha_hasta = hash[:fecha_hasta]
			self.vencidos = hash[:vencidos]
		end
	end

	def nacimiento_to_date
		begin
			f = Date.strptime(self.nacimiento_afiliado, '%d/%m/%Y')
		rescue
			nil
		else
			f
		end
	end

	def fecha_desde_to_date
		begin
			f = Date.strptime(self.fecha_desde, '%d/%m/%Y')
		rescue
			nil
		else
			f
		end
	end

	def fecha_hasta_to_date
		begin
			f = Date.strptime(self.fecha_hasta, '%d/%m/%Y')
		rescue
			nil
		else
			f
		end
	end
end
