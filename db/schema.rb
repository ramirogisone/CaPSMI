# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110907173608) do

  create_table "afiliados", :force => true do |t|
    t.string    "nombre"
    t.date      "nacimiento"
    t.date      "fallecimiento"
    t.string    "lugar_nacimiento"
    t.string    "tipo_documento"
    t.float     "documento"
    t.string    "estado_civil"
    t.string    "titulo"
    t.string    "universidad"
    t.date      "fecha_titulo"
    t.string    "matricula"
    t.date      "fecha_matricula"
    t.string    "colegio_profesional"
    t.string    "numero_colegio_profesional"
    t.float     "cuit"
    t.date      "inicio_devengamiento"
    t.date      "final_devengamiento"
    t.date      "inicio_afiliacion"
    t.string    "codigo_agrupacion"
    t.string    "sexo"
    t.text      "observaciones"
    t.string    "domicilio_particular"
    t.string    "ciudad_particular"
    t.string    "codigo_postal_particular"
    t.string    "provincia_particular"
    t.string    "telefonos_particular"
    t.string    "fax_particular"
    t.string    "e_mail_particular"
    t.string    "domicilio_profesional"
    t.string    "ciudad_profesional"
    t.string    "codigo_postal_profesional"
    t.string    "provincia_profesional"
    t.string    "telefonos_profesional"
    t.string    "fax_profesional"
    t.string    "e_mail_profesional"
    t.string    "regimen_iva"
    t.string    "area_geografica"
    t.date      "fec_grab"
    t.string    "hor_grab"
    t.string    "usr_grab"
    t.string    "wks_grab"
    t.string    "tip_grab"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "boletas", :force => true do |t|
    t.date      "vencimiento"
    t.integer   "afiliado_id"
    t.float     "total"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "boletas_vencimientos", :id => false, :force => true do |t|
    t.integer "boleta_id"
    t.integer "vencimiento_id"
  end

  create_table "comprobantes_de_compras", :force => true do |t|
    t.date      "fecha"
    t.string    "tipo"
    t.integer   "centro"
    t.integer   "numero"
    t.integer   "proveedor_id"
    t.integer   "user_id"
    t.string    "domicilio"
    t.string    "ciudad"
    t.string    "codigo_postal"
    t.string    "provincia"
    t.string    "telefonos"
    t.string    "regimen_iva"
    t.float     "total"
    t.date      "fec_grab"
    t.string    "hor_grab"
    t.string    "usr_grab"
    t.string    "wks_grab"
    t.string    "tip_grab"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "comprobantes_de_mesa_de_entrada", :force => true do |t|
    t.string    "tipo"
    t.date      "fecha"
    t.integer   "numero"
    t.integer   "user_id"
    t.text      "observaciones"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "cuentas_de_proveedores", :force => true do |t|
    t.integer   "comprobante_de_compra_id"
    t.date      "fecha"
    t.string    "tipo"
    t.integer   "centro"
    t.integer   "numero"
    t.integer   "proveedor_id"
    t.string    "clase_valor"
    t.integer   "lote_valor"
    t.integer   "numero_valor"
    t.date      "fecha_valor"
    t.string    "movimiento"
    t.float     "importe"
    t.string    "tipo_aplicado"
    t.integer   "centro_aplicado"
    t.integer   "numero_aplicado"
    t.date      "fecha_aplicado"
    t.date      "vencimiento"
    t.string    "detalle"
    t.date      "fec_grab"
    t.string    "hor_grab"
    t.string    "wks_grab"
    t.string    "tip_grab"
    t.string    "usr_grab"
    t.integer   "rec_grab"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "expedientes", :force => true do |t|
    t.string    "nombre"
    t.integer   "tipo_de_expediente_id"
    t.text      "observaciones"
    t.integer   "afiliado_id"
    t.date      "fecha_de_apertura"
    t.date      "fecha_de_cierre"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "imagenes_de_legajos", :force => true do |t|
    t.integer   "legajo_id"
    t.string    "tipo"
    t.string    "nombre"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "imagen_file_name"
    t.string    "imagen_content_type"
    t.integer   "imagen_file_size"
    t.timestamp "imagen_updated_at"
  end

  create_table "importaciones_de_vencimientos", :force => true do |t|
    t.date      "fecha"
    t.text      "informe"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "archivo_csv_file_name"
    t.string    "archivo_csv_content_type"
    t.integer   "archivo_csv_file_size"
    t.timestamp "archivo_csv_updated_at"
  end

  create_table "instancias", :force => true do |t|
    t.string    "nombre"
    t.text      "observaciones"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "legajos", :force => true do |t|
    t.string    "apellido"
    t.string    "nombres"
    t.date      "nacimiento"
    t.string    "tipo_documento"
    t.float     "documento"
    t.float     "cuil"
    t.string    "estado_civil"
    t.string    "domicilio"
    t.string    "ciudad"
    t.string    "codigo_postal"
    t.string    "telefonos"
    t.date      "ingreso"
    t.string    "categoria"
    t.date      "egreso"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "legajo"
  end

  create_table "links", :force => true do |t|
    t.string    "posicion"
    t.string    "nombre"
    t.string    "controlador"
    t.string    "accion"
    t.string    "estado"
    t.string    "formato"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "links_users", :force => true do |t|
    t.integer   "link_id"
    t.integer   "user_id"
    t.boolean   "alta"
    t.boolean   "baja"
    t.boolean   "modificacion"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "movimientos_de_mesa_de_entrada", :force => true do |t|
    t.integer   "comprobante_de_mesa_de_entrada_id"
    t.integer   "expediente_id"
    t.integer   "instancia_origen_id"
    t.integer   "instancia_destino_id"
    t.string    "tipo"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.text      "informe"
    t.integer   "dias_plazo"
  end

  create_table "proveedores", :force => true do |t|
    t.string    "nombre"
    t.string    "codigo_agrupacion"
    t.text      "observaciones"
    t.string    "domicilio"
    t.string    "ciudad"
    t.string    "codigo_postal"
    t.string    "provincia"
    t.string    "telefonos"
    t.string    "fax"
    t.string    "e_mail"
    t.string    "area_geografica"
    t.date      "fec_grab"
    t.string    "hor_grab"
    t.string    "usr_grab"
    t.string    "wks_grab"
    t.string    "tip_grab"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "regimen_iva"
    t.float     "cuit"
  end

  create_table "rutas_predefinidas", :force => true do |t|
    t.integer   "tipo_de_expediente_id"
    t.integer   "instancia_id"
    t.integer   "paso"
    t.integer   "dias_plazo"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "tipos_de_expedientes", :force => true do |t|
    t.string    "posicion"
    t.string    "nombre"
    t.text      "observacion"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "nombre"
    t.string    "login",                              :null => false
    t.string    "email"
    t.string    "crypted_password",                   :null => false
    t.string    "password_salt",                      :null => false
    t.string    "persistence_token",                  :null => false
    t.string    "single_access_token",                :null => false
    t.string    "perishable_token",                   :null => false
    t.integer   "login_count",         :default => 0, :null => false
    t.integer   "failed_login_count",  :default => 0, :null => false
    t.timestamp "last_request_at"
    t.timestamp "current_login_at"
    t.timestamp "last_login_at"
    t.string    "current_login_ip"
    t.string    "last_login_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "password_field"
  end

  create_table "vencimientos", :force => true do |t|
    t.integer   "afiliado_id"
    t.string    "tipo_comprobante"
    t.integer   "centro_comprobante",            :default => 0
    t.float     "numero_comprobante",            :default => 0.0
    t.date      "fecha_comprobante",             :default => '2011-05-16'
    t.date      "vencimiento",                   :default => '2011-05-16'
    t.string    "detalle"
    t.float     "importe",                       :default => 0.0
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "importacion_de_vencimiento_id"
    t.string    "tipo"
  end

end
