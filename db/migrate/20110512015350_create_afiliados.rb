class CreateAfiliados < ActiveRecord::Migration
  def self.up
    create_table :afiliados do |t|
      t.string :nombre
      t.date :nacimiento
      t.date :fallecimiento
      t.string :lugar_nacimiento
      t.string :tipo_documento
      t.float :documento
      t.string :estado_civil
      t.string :titulo
      t.string :universidad
      t.date :fecha_titulo
      t.string :matricula
      t.date :fecha_matricula
      t.string :colegio_profesional
      t.string :numero_colegio_profesional
      t.float :cuit
      t.date :inicio_devengamiento
      t.date :final_devengamiento
      t.date :inicio_afiliacion
      t.string :codigo_agrupacion
      t.string :sexo
      t.text :observaciones
      t.string :domicilio_particular
      t.string :ciudad_particular
      t.string :codigo_postal_particular
      t.string :provincia_particular
      t.string :telefonos_particular
      t.string :fax_particular
      t.string :e_mail_particular
      t.string :domicilio_profesional
      t.string :ciudad_profesional
      t.string :codigo_postal_profesional
      t.string :provincia_profesional
      t.string :telefonos_profesional
      t.string :fax_profesional
      t.string :e_mail_profesional
      t.string :regimen_iva
      t.string :area_geografica
      t.date :fec_grab
      t.string :hor_grab
      t.string :usr_grab
      t.string :wks_grab
      t.string :tip_grab

      t.timestamps
    end
    change_column :afiliados, :id, :integer
  end

  def self.down
    drop_table :afiliados
  end
end
