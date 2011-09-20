class MovimientoDeMesaDeEntrada < ActiveRecord::Base

	attr_accessor :tipo_comprobante, :nombre_expediente, :nombre_instancia_origen, :nombre_instancia_destino,
		:entrada, :pase, :salida
	
	belongs_to :comprobante_de_mesa_de_entrada
	belongs_to :expediente
	belongs_to :instancia_origen
	belongs_to :instancia_destino
	
	cattr_reader :per_page
	@@per_page = 24
	
	validates_presence_of :expediente_id, :instancia_origen_id, :instancia_destino_id, :message => "no puede estar vacío."
	validate :desigualdad_instancia_origen_e_instancia_destino, :dias_plazo_mayor_cero
	
	def after_find
		self.nombre_expediente = self.expediente ? self.expediente.nombre : "No hay expediente: #{@expediente_id}"
		self.nombre_instancia_origen = self.instancia_origen ? self.instancia_origen.nombre : "No hay instancia: #{@instancia_origen_id}"
		self.nombre_instancia_destino = self.instancia_destino ? self.instancia_destino.nombre : "No hay instancia: #{@instancia_destino_id}"
	end
	
	def initialize(*args)
		super(*args)
		if self.tipo_comprobante
			self.tipo = case self.tipo_comprobante
				when 'IME' then 'Entrada'
				when 'ARCH' then 'Salida'
				when 'PAS' then 'Pase'
			end
		end
	end
	
	def desigualdad_instancia_origen_e_instancia_destino
		if self.tipo == 'Pase'
			if self.instancia_origen_id == self.instancia_destino_id 
				errors.add(:instancia_destino, 'debe ser distinta a Instancia origen')
				return false
			end
		end
	end

	def dias_plazo_mayor_cero
		if self.dias_plazo < 1    
			errors.add(:instancia_destino, 'debe ser distinta a Instancia origen')
			return false
		end
	end

	named_scope :por_fecha,
		lambda {|f| {
			:include => :comprobante_de_mesa_de_entrada,
			:select => '*, MAXIMUM(comprobante_de_mesa_de_entrada.fecha) AS ultima_fecha',
			:conditions => ['comprobantes_de_mesa_de_entrada.fecha <= ?', f],
			:group => :expediente_id }
		}

end
