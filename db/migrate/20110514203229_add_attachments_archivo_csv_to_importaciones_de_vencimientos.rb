class AddAttachmentsArchivoCsvToImportacionesDeVencimientos < ActiveRecord::Migration
  def self.up
    add_column :importaciones_de_vencimientos, :archivo_csv_file_name, :string
    add_column :importaciones_de_vencimientos, :archivo_csv_content_type, :string
    add_column :importaciones_de_vencimientos, :archivo_csv_file_size, :integer
    add_column :importaciones_de_vencimientos, :archivo_csv_updated_at, :datetime
  end

  def self.down
    remove_column :importaciones_de_vencimientos, :archivo_csv_file_name
    remove_column :importaciones_de_vencimientos, :archivo_csv_content_type
    remove_column :importaciones_de_vencimientos, :archivo_csv_file_size
    remove_column :importaciones_de_vencimientos, :archivo_csv_updated_at
  end
end
