Prawn::Document.new(:top_margin => 10, :page_size => "A4", :page_layout => :landscape) do |pdf|
	pdf.font "Helvetica", :size => 10
	pdf.table @afiliados, :header => false, :row_colors => ["F0F0F0", "FFFFCC"]
end
