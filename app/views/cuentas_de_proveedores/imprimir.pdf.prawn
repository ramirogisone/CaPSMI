Prawn::Document.new(:top_margin => 5, :left_margin => 12, :right_margin => 12,
		:page_size => "A4", :page_layout => :portrait) do |pdf|

	pdf.bounding_box [14, pdf.bounds.top], :width => 550 do
		pdf.stroke_rectangle([0,0], 550, 805)
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
		pdf.text_box("Resumen de cuenta",
			:at => [x,y], :width => ancho, :height => alto, :align => :center, :size => 16)					

		x = 0; y = -93; ancho = 550; alto = 40
		pdf.stroke_rectangle [x,y], ancho, alto
		pdf.fill_color "F0F0F0"
		pdf.fill_rectangle [x+5,y-5], ancho-10, alto-10
		pdf.fill_color "000000"
		pdf.text_box("Proveedor: #{@proveedor.id} - #{@proveedor.nombre}",
			:at => [x,y-15], :width => ancho, :height => 14, :align => :center,
			:size => 14, :style => :bold)

		pdf.font "Helvetica", :size => 8
		pdf.bounding_box([5,-145], :width => 540) do
			pdf.table @lineas do |t|
				t.cell_style = {:borders => []}
				t.row_colors = ["F0F0F0", "FFFFFF"]
				t.column(0).font_style = :bold
				t.row(0).column(0..8).font_style = :bold 
				t.column(3).width = 100
				t.column(4..6).align = :right
				t.cells[0,4].align = t.cells[0,5].align = t.cells[0,6].align = :left
			end
		end

	end

	x = 0; y = -10; ancho = 550; alto = 20
	pdf.text_box("Las Piedras 496 - 5to piso Tel: +54 381 4306022 - San Miguel de Tucumán - CUIT: 30707229779",
		:at => [x,y], :width => ancho, :height => alto, :align => :center, :size => 8)

end
