ActionController::Routing::Routes.draw do |map|
	map.resource :user_session
	map.namespace :admin do |admin|
		admin.connect 'links_users/:action',
			:controller => 'links_users', :action => [:lista]
		admin.resources :users do |u|
			u.resources :users_links
		end
		admin.resources :links do |l|
			l.resources :links_users
		end
	end
	map.resources :afiliados, :collection => { :importar  => :get, :buscar  => :get, :listar  => :get }
	map.resources :vencimientos
	map.resources :importaciones_de_vencimientos
	# Boletas
	map.resources :boletas, :only => [ :index, :destroy ]
	map.connect 'boletas/:action', :controller => 'boletas', :action => [ :buscar, :imprimir ]
	# Legajos
	map.resources :legajos do |l|
		l.resources :imagenes_de_legajos
	end
	map.connect 'imagenes_de_legajos/:action',
		:controller => 'imagenes_de_legajos', :action => [:listar]
	# Tipos de expedientes
	map.resources :tipos_de_expedientes, :singular => "tipo_de_expediente" do |l|
		l.resources :rutas_predefinidas
	end
	map.connect 'rutas_predefinidas/:action', :controller => 'rutas_predefinidas',
		:action => [:lista, :mueve_arriba, :mueve_abajo]
	#
	map.resources :instancias
	map.resources :expedientes
	# Comprobantes de mesa de entrada
	map.resources :comprobantes_de_mesa_de_entrada,
			:singular => "comprobante_de_mesa_de_entrada", :collection => {:imprimir => :get} do |c|
		c.resources :movimientos_de_mesa_de_entrada, :singular => "movimiento_de_mesa_de_entrada"
	end
	map.connect 'movimientos_de_mesa_de_entrada/:action', :controller => 'movimientos_de_mesa_de_entrada',
		:action => [:lista, :impulsa_expediente, :consultar, :consultar_por_fecha]
	# Proveedores
	map.resources :proveedores, :collection => {:index_full => :get, :importar => :get}
	# Comprobantes de compras
	map.resources :comprobantes_de_compras,
			:collection => { :get_proveedor  => :post, :imprimir => :get, :importar => :get } do |c|
		c.resources :cuentas_de_proveedores
	end
	map.connect 'cuentas_de_proveedores/:action', :controller => 'cuentas_de_proveedores',
		:action => [:importar, :listar, :consultar]
	# Raiz
	map.root :controller => 'boletas', :action => 'buscar'
end
