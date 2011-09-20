# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.uncountable %w( fish sheep )
	inflect.irregular 'vencimiento', 'vencimientos'
	inflect.irregular 'importacion_de_vencimiento', 'importaciones_de_vencimientos'
	inflect.irregular 'imagen_de_legajo', 'imagenes_de_legajos'
	inflect.irregular 'tipo_de_expediente', 'tipos_de_expedientes'
	inflect.irregular 'instancia', 'instancias'
	inflect.irregular 'expediente', 'expedientes'
	inflect.irregular 'comprobante_de_mesa_de_entrada', 'comprobantes_de_mesa_de_entrada'
	inflect.irregular 'ruta_predefinida', 'rutas_predefinidas'
	inflect.irregular 'movimiento_de_mesa_de_entrada', 'movimientos_de_mesa_de_entrada'
	inflect.irregular 'link_user', 'links_users'
	inflect.irregular 'user_link', 'users_links'
	inflect.irregular 'proveedor', 'proveedores'
	inflect.irregular 'cuenta_de_proveedor', 'cuentas_de_proveedores'
	inflect.irregular 'comprobante_de_compra', 'comprobantes_de_compras'
end
