require 'test_helper'

class VencimientosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vencimientos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vencimiento" do
    assert_difference('Vencimiento.count') do
      post :create, :vencimiento => { }
    end

    assert_redirected_to vencimiento_path(assigns(:vencimiento))
  end

  test "should show vencimiento" do
    get :show, :id => vencimientos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => vencimientos(:one).to_param
    assert_response :success
  end

  test "should update vencimiento" do
    put :update, :id => vencimientos(:one).to_param, :vencimiento => { }
    assert_redirected_to vencimiento_path(assigns(:vencimiento))
  end

  test "should destroy vencimiento" do
    assert_difference('Vencimiento.count', -1) do
      delete :destroy, :id => vencimientos(:one).to_param
    end

    assert_redirected_to vencimientos_path
  end
end
