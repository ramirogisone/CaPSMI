require 'test_helper'

class ImportacionesDeVencimientosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:importaciones_de_vencimientos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create importacion_de_vencimiento" do
    assert_difference('ImportacionDeVencimiento.count') do
      post :create, :importacion_de_vencimiento => { }
    end

    assert_redirected_to importacion_de_vencimiento_path(assigns(:importacion_de_vencimiento))
  end

  test "should show importacion_de_vencimiento" do
    get :show, :id => importaciones_de_vencimientos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => importaciones_de_vencimientos(:one).to_param
    assert_response :success
  end

  test "should update importacion_de_vencimiento" do
    put :update, :id => importaciones_de_vencimientos(:one).to_param, :importacion_de_vencimiento => { }
    assert_redirected_to importacion_de_vencimiento_path(assigns(:importacion_de_vencimiento))
  end

  test "should destroy importacion_de_vencimiento" do
    assert_difference('ImportacionDeVencimiento.count', -1) do
      delete :destroy, :id => importaciones_de_vencimientos(:one).to_param
    end

    assert_redirected_to importaciones_de_vencimientos_path
  end
end
