require 'test_helper'

class TiposDeExpedientesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipos_de_expedientes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_de_expediente" do
    assert_difference('TipoDeExpediente.count') do
      post :create, :tipo_de_expediente => { }
    end

    assert_redirected_to tipo_de_expediente_path(assigns(:tipo_de_expediente))
  end

  test "should show tipo_de_expediente" do
    get :show, :id => tipos_de_expedientes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tipos_de_expedientes(:one).to_param
    assert_response :success
  end

  test "should update tipo_de_expediente" do
    put :update, :id => tipos_de_expedientes(:one).to_param, :tipo_de_expediente => { }
    assert_redirected_to tipo_de_expediente_path(assigns(:tipo_de_expediente))
  end

  test "should destroy tipo_de_expediente" do
    assert_difference('TipoDeExpediente.count', -1) do
      delete :destroy, :id => tipos_de_expedientes(:one).to_param
    end

    assert_redirected_to tipos_de_expedientes_path
  end
end
