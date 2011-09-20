Prawn::Document.new(:top_margin => 5, :left_margin => 12, :page_size => "A4", :page_layout => :portrait) do |pdf|

	pdf.bounding_box [14, pdf.bounds.top], :width => 550 do
		pdf.stroke_rectangle([0,0], 550, 400)
		pdf.image "#{RAILS_ROOT}/public/images/logo_caja_boleta.jpg", :at => [5,-7], :width => 60

		x = pdf.bounds.right-145; y = -10; ancho = 140; alto = 100
		pdf.text_box(
				"Caja de Previsión y
				 Seguridad Social de
				 Médicos e Ingenieros
				 de Tucumán\n\n
				 www.capsmi.org.ar
				 capsmi@capsmi.org.ar",
			:at => [x,y], :width => ancho, :height => alto, :align => :right, :size => 9)

		x = 0; y = -40; ancho = 550; alto = 40
		pdf.text_box("Comprobante de mesa de entrada",
			:at => [x,y], :width => ancho, :height => alto, :align => :center, :size => 16)					

		x = 0; y = -93; ancho = 550; alto = 80
		pdf.stroke_rectangle [x,y], ancho, alto
		pdf.fill_color "F0F0F0"
		pdf.fill_rectangle [x+45,y-10], ancho/2-45, alto-20
		pdf.fill_color "000000"

		pdf.stroke_rectangle [x+5,y-5], ancho / 2, alto -10
		y2 = y
		[["Id:", @cabecera.id.to_s],
			["Fecha:", @cabecera.fecha],
			["Tipo:", @cabecera.tipo], 
			["Número:", @cabecera.numero],
			["Usuario:", @usuario]].each do |field|
				pdf.text_box(field[0],
					:at => [x+10,y2-15], :width => ancho, :height => alto, :align => :left, :size => 8,
					:style => :bold)
				pdf.text_box("#{field[1]}",
					:at => [x+50,y2-15], :width => ancho, :height => alto, :align => :left,
					:size => 8, :style => :normal)
				y2 = y2 - 10
		end

		x = x+(ancho/2)+10; y = y-5; ancho = (ancho/2)-15; alto = alto-10
		pdf.stroke_rectangle [x,y], ancho, alto
		pdf.fill_color "F0F0F0"
		pdf.fill_rectangle [x+5,y-5], ancho-10, alto-10
		pdf.fill_color "000000"
		pdf.text_box("Observaciones:",
			:at => [x+10,y-10], :width => ancho, :height => 10, :align => :left, :size => 9, :style => :bold)
		pdf.text_box("#{@cabecera.observaciones}",
			:at => [x+10,y-20], :width => ancho, :height => 30, :align => :left, :size => 9, :style => :normal)

		pdf.font "Helvetica", :size => 8
		pdf.bounding_box([25,-178], :width => 510) do
			pdf.table @lineas do |t|
				t.cell_style = {:borders => []}
				t.row_colors = ["F0F0F0", "FFFFFF"]
				t.column(0).width = 140
				t.column(1).width = 150
				t.column(2).width = 40
				t.column(3).width = 30
				t.column(4).width = 140
			end
		end
	end

	x = 0; y = 395; ancho = 550; alto = 20
	pdf.text_box("Las Piedras 496 - 5to piso Tel: +54 381 4306022 - San Miguel de Tucumán - CUIT: 30707229779",
		:at => [x,y], :width => ancho, :height => alto, :align => :center, :size => 8)

end
