MovimientoDeMesaDeEntrada.por_fecha('2011-09-15').each do |m|
	puts m.expediente_id, m.expediente.nombre, m["ultima_fecha"]
end
