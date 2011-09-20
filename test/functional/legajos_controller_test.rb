require 'test_helper'

class LegajosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:legajos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create legajo" do
    assert_difference('Legajo.count') do
      post :create, :legajo => { }
    end

    assert_redirected_to legajo_path(assigns(:legajo))
  end

  test "should show legajo" do
    get :show, :id => legajos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => legajos(:one).to_param
    assert_response :success
  end

  test "should update legajo" do
    put :update, :id => legajos(:one).to_param, :legajo => { }
    assert_redirected_to legajo_path(assigns(:legajo))
  end

  test "should destroy legajo" do
    assert_difference('Legajo.count', -1) do
      delete :destroy, :id => legajos(:one).to_param
    end

    assert_redirected_to legajos_path
  end
end
