require 'test_helper'

class ExpedientesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expedientes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create expediente" do
    assert_difference('Expediente.count') do
      post :create, :expediente => { }
    end

    assert_redirected_to expediente_path(assigns(:expediente))
  end

  test "should show expediente" do
    get :show, :id => expedientes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => expedientes(:one).to_param
    assert_response :success
  end

  test "should update expediente" do
    put :update, :id => expedientes(:one).to_param, :expediente => { }
    assert_redirected_to expediente_path(assigns(:expediente))
  end

  test "should destroy expediente" do
    assert_difference('Expediente.count', -1) do
      delete :destroy, :id => expedientes(:one).to_param
    end

    assert_redirected_to expedientes_path
  end
end
