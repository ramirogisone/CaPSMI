require 'test_helper'

class CuentasDeProveedoresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuentas_de_proveedores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuenta_de_proveedor" do
    assert_difference('CuentaDeProveedor.count') do
      post :create, :cuenta_de_proveedor => { }
    end

    assert_redirected_to cuenta_de_proveedor_path(assigns(:cuenta_de_proveedor))
  end

  test "should show cuenta_de_proveedor" do
    get :show, :id => cuentas_de_proveedores(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cuentas_de_proveedores(:one).to_param
    assert_response :success
  end

  test "should update cuenta_de_proveedor" do
    put :update, :id => cuentas_de_proveedores(:one).to_param, :cuenta_de_proveedor => { }
    assert_redirected_to cuenta_de_proveedor_path(assigns(:cuenta_de_proveedor))
  end

  test "should destroy cuenta_de_proveedor" do
    assert_difference('CuentaDeProveedor.count', -1) do
      delete :destroy, :id => cuentas_de_proveedores(:one).to_param
    end

    assert_redirected_to cuentas_de_proveedores_path
  end
end
