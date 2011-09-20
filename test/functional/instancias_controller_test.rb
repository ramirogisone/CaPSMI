require 'test_helper'

class InstanciasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instancias)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instancia" do
    assert_difference('Instancia.count') do
      post :create, :instancia => { }
    end

    assert_redirected_to instancia_path(assigns(:instancia))
  end

  test "should show instancia" do
    get :show, :id => instancias(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => instancias(:one).to_param
    assert_response :success
  end

  test "should update instancia" do
    put :update, :id => instancias(:one).to_param, :instancia => { }
    assert_redirected_to instancia_path(assigns(:instancia))
  end

  test "should destroy instancia" do
    assert_difference('Instancia.count', -1) do
      delete :destroy, :id => instancias(:one).to_param
    end

    assert_redirected_to instancias_path
  end
end
