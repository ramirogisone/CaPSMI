class AddAttachmentsImagenToImagenesDeLegajos < ActiveRecord::Migration
  def self.up
    add_column :imagenes_de_legajos, :imagen_file_name, :string
    add_column :imagenes_de_legajos, :imagen_content_type, :string
    add_column :imagenes_de_legajos, :imagen_file_size, :integer
    add_column :imagenes_de_legajos, :imagen_updated_at, :datetime
  end

  def self.down
    remove_column :imagenes_de_legajos, :imagen_file_name
    remove_column :imagenes_de_legajos, :imagen_content_type
    remove_column :imagenes_de_legajos, :imagen_file_size
    remove_column :imagenes_de_legajos, :imagen_updated_at
  end
end
