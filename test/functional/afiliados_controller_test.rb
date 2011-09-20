require 'test_helper'

class AfiliadosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:afiliados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create afiliado" do
    assert_difference('Afiliado.count') do
      post :create, :afiliado => { }
    end

    assert_redirected_to afiliado_path(assigns(:afiliado))
  end

  test "should show afiliado" do
    get :show, :id => afiliados(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => afiliados(:one).to_param
    assert_response :success
  end

  test "should update afiliado" do
    put :update, :id => afiliados(:one).to_param, :afiliado => { }
    assert_redirected_to afiliado_path(assigns(:afiliado))
  end

  test "should destroy afiliado" do
    assert_difference('Afiliado.count', -1) do
      delete :destroy, :id => afiliados(:one).to_param
    end

    assert_redirected_to afiliados_path
  end
end
