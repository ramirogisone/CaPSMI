require 'test_helper'

class ComprobantesDeMesaDeEntradaControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comprobantes_de_mesa_de_entrada)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comprobante_de_mesa_de_entrada" do
    assert_difference('ComprobanteDeMesaDeEntrada.count') do
      post :create, :comprobante_de_mesa_de_entrada => { }
    end

    assert_redirected_to comprobante_de_mesa_de_entrada_path(assigns(:comprobante_de_mesa_de_entrada))
  end

  test "should show comprobante_de_mesa_de_entrada" do
    get :show, :id => comprobantes_de_mesa_de_entrada(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => comprobantes_de_mesa_de_entrada(:one).to_param
    assert_response :success
  end

  test "should update comprobante_de_mesa_de_entrada" do
    put :update, :id => comprobantes_de_mesa_de_entrada(:one).to_param, :comprobante_de_mesa_de_entrada => { }
    assert_redirected_to comprobante_de_mesa_de_entrada_path(assigns(:comprobante_de_mesa_de_entrada))
  end

  test "should destroy comprobante_de_mesa_de_entrada" do
    assert_difference('ComprobanteDeMesaDeEntrada.count', -1) do
      delete :destroy, :id => comprobantes_de_mesa_de_entrada(:one).to_param
    end

    assert_redirected_to comprobantes_de_mesa_de_entrada_path
  end
end
