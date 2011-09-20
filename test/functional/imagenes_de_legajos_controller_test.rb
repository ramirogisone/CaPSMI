require 'test_helper'

class ImagenesDeLegajosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imagenes_de_legajos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imagen_de_legajo" do
    assert_difference('ImagenDeLegajo.count') do
      post :create, :imagen_de_legajo => { }
    end

    assert_redirected_to imagen_de_legajo_path(assigns(:imagen_de_legajo))
  end

  test "should show imagen_de_legajo" do
    get :show, :id => imagenes_de_legajos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => imagenes_de_legajos(:one).to_param
    assert_response :success
  end

  test "should update imagen_de_legajo" do
    put :update, :id => imagenes_de_legajos(:one).to_param, :imagen_de_legajo => { }
    assert_redirected_to imagen_de_legajo_path(assigns(:imagen_de_legajo))
  end

  test "should destroy imagen_de_legajo" do
    assert_difference('ImagenDeLegajo.count', -1) do
      delete :destroy, :id => imagenes_de_legajos(:one).to_param
    end

    assert_redirected_to imagenes_de_legajos_path
  end
end
