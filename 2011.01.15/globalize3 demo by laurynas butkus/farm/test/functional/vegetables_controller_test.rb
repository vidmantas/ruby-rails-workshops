require 'test_helper'

class VegetablesControllerTest < ActionController::TestCase
  setup do
    @vegetable = vegetables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vegetables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vegetable" do
    assert_difference('Vegetable.count') do
      post :create, :vegetable => @vegetable.attributes
    end

    assert_redirected_to vegetable_path(assigns(:vegetable))
  end

  test "should show vegetable" do
    get :show, :id => @vegetable.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @vegetable.to_param
    assert_response :success
  end

  test "should update vegetable" do
    put :update, :id => @vegetable.to_param, :vegetable => @vegetable.attributes
    assert_redirected_to vegetable_path(assigns(:vegetable))
  end

  test "should destroy vegetable" do
    assert_difference('Vegetable.count', -1) do
      delete :destroy, :id => @vegetable.to_param
    end

    assert_redirected_to vegetables_path
  end
end
