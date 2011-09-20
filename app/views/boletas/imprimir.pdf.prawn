require 'barby'
require 'barby/outputter/prawn_outputter'

Prawn::Document.new(:top_margin => 5, :left_margin => 12, :page_size => "A4", :page_layout => :portrait) do |pdf|
	pdf.rotate(-90, :origin => [287,508]) do
		%w(0 285 570).each do |@pos|
			pdf.bounding_box [@pos.to_i, pdf.bounds.top], :width => 250 do
				pdf.stroke_rectangle([0,0], 250, 585)
				pdf.image "#{RAILS_ROOT}/public/images/logo_caja_boleta.jpg", :at => [5,-7], :width => 60

				x = 70; y = -8; ancho = 100; alto = 40
				#pdf.fill_color "green" 
				#pdf.fill_rectangle [x,y], ancho, alto
				#pdf.fill_color "000000"
				pdf.text_box(
						"Caja de Previsión y
						 Seguridad Social de
					 	Médicos e Ingenieros
					 	de Tucumán",
					:at => [x,y], :width => ancho, :height => alto, :align => :left, :size => 9)

				x = 70; y = -52; ancho = 100; alto = 35
				#pdf.fill_color "cccccc" 
				#pdf.fill_rectangle [x,y], ancho, alto
				#pdf.fill_color "000000"
				pdf.text_box(
						"CUIT: 30707229779
				 		Tel: +54 381 4306022 
				 		Las Piedras 496 - 5to piso
				 		San Miguel de Tucumán",
					:at => [x,y], :width => ancho, :height => alto, :align => :left, :size => 7)

				x = 172; y = -8; ancho = 70; alto = 40
				pdf.fill_color "F0F0F0"
  				pdf.fill_rectangle [x,y], ancho, alto
  				pdf.fill_color "000000"
				pdf.text_box("Nro de boleta\n #{'%08d' % @boleta.id}",
					:at => [x,y-3], :width => ancho, :height => alto, :align => :center, :size => 11, :style => :bold)

				x = 172; y = -53; ancho = 70; alto = 30
				pdf.fill_color "F0F0F0"
				pdf.fill_rectangle [x,y], ancho, alto
				pdf.fill_color "000000"
				pdf.text_box("Válida hasta el #{@boleta.vencimiento}",
					:at => [x,y-5], :width => ancho, :height => alto, :align => :center, :size => 9, :style => :bold)

				pdf.stroke_rectangle [0,-93], 250, 84

				x = 8; y = -103; ancho = 234; alto = 15
				pdf.fill_color "F0F0F0"
				pdf.fill_rectangle [x+52,y], ancho-52, (alto+1)*4
				pdf.fill_color "000000"
				[["Nro. CaPSMI:", @afiliado.id.to_s+'  Período: '+
						I18n.localize(@boleta.vencimiento, :format => '%B-%Y')],
						["Afiliado:", @afiliado.nombre], ["Domicilio:", @afiliado.domicilio_particular],
						["Ciudad:", "(#{@afiliado.codigo_postal_particular})  #{@afiliado.ciudad_particular}"],
						["Provincia:", @afiliado.provincia_particular], ["Documento:",
						number_with_delimiter(@afiliado.documento.round, :delimiter => ".")]].each do |field|
					pdf.text_box(field[0],
						:at => [x,y-5], :width => ancho, :height => alto, :align => :left, :size => 8,
						:style => :bold)
					pdf.text_box(field[1],
						:at => [x+55,y-3], :width => ancho, :height => alto, :align => :left,
						:size => 10, :style => (field[0] == 'Nro. CaPSMI:' ? :bold : :normal))
					y = y - 10
				end

				pdf.font "Helvetica", :size => 8
				pdf.bounding_box([1,-178], :width => 248) do
					pdf.table @vencimientos do |t|
						t.cell_style = {:borders => []}
						t.row_colors = ["F0F0F0", "FFFFFF"]
						t.column(1).width = 50
						t.column(1).align = :right
						t.column(1).font_style = :bold
						t.column(1).size = 10
						t.cells[0,0].font_style = :bold
						t.cells[0,1].align = :left
					end
				end

				pdf.pad_top(5) do
					pdf.text "Son pesos #{@total.to_letras}", :align => :center, :size => 8
					pdf.text "\n Autorizado a pagar en BANCO \n hasta el #{@boleta.vencimiento}",
						:align => :center, :size => 10, :style => :bold
					pdf.text "\n BANCO MACRO SA CTA Nº 10626/5", :align => :center, :size => 10
					pdf.text "\n BANCO HSBC CTA Nº 0523281270", :align => :center, :size => 10
					pdf.text "\n Copia para " + (@pos == '0' ? 'el BANCO' : @pos == '285' ? 'CaPSMI' : 'AFILIADO'),
						:align => :center, :size => 10
  				end

				#pdf.bounding_box [65, pdf.bounds.top-540], :width => 120 do
				#	barcode = Barby::Code128B.new("#{'%08d' % @boleta.id}")
  				#	barcode.annotate_pdf(pdf, :height => 30)
				#	pdf.text "#{'%08d' % @boleta.id}", :align => :center
				#end
			
  				x = 0; y = pdf.bounds.top-550; ancho = 250; alto = 40
				pdf.text_box "Visítenos en: www.capsmi.org.ar \n e-mail: capsmi@capsmi.org.ar",
					:at => [x,y], :width => ancho, :height => alto, :align => :center, :size => 12, :style => :bold
			
			end
		end
	end

	pdf.dash = 5
	pdf.stroke_rectangle([-20,526], 610, 284)
	#pdf.stroke_rectangle([267,560], 285, 600)

end
