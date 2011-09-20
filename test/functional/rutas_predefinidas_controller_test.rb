require 'test_helper'

class RutasPredefinidasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rutas_predefinidas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ruta_predefinida" do
    assert_difference('RutaPredefinida.count') do
      post :create, :ruta_predefinida => { }
    end

    assert_redirected_to ruta_predefinida_path(assigns(:ruta_predefinida))
  end

  test "should show ruta_predefinida" do
    get :show, :id => rutas_predefinidas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => rutas_predefinidas(:one).to_param
    assert_response :success
  end

  test "should update ruta_predefinida" do
    put :update, :id => rutas_predefinidas(:one).to_param, :ruta_predefinida => { }
    assert_redirected_to ruta_predefinida_path(assigns(:ruta_predefinida))
  end

  test "should destroy ruta_predefinida" do
    assert_difference('RutaPredefinida.count', -1) do
      delete :destroy, :id => rutas_predefinidas(:one).to_param
    end

    assert_redirected_to rutas_predefinidas_path
  end
end
