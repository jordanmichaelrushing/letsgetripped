require 'test_helper'

class CalfCrunchesControllerTest < ActionController::TestCase
  setup do
    @calf_crunch = calf_crunches(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calf_crunches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calf_crunch" do
    assert_difference('CalfCrunch.count') do
      post :create, calf_crunch: { calf: @calf_crunch.calf, crunch: @calf_crunch.crunch, reps: @calf_crunch.reps, set_num: @calf_crunch.set_num }
    end

    assert_redirected_to calf_crunch_path(assigns(:calf_crunch))
  end

  test "should show calf_crunch" do
    get :show, id: @calf_crunch
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calf_crunch
    assert_response :success
  end

  test "should update calf_crunch" do
    patch :update, id: @calf_crunch, calf_crunch: { calf: @calf_crunch.calf, crunch: @calf_crunch.crunch, reps: @calf_crunch.reps, set_num: @calf_crunch.set_num }
    assert_redirected_to calf_crunch_path(assigns(:calf_crunch))
  end

  test "should destroy calf_crunch" do
    assert_difference('CalfCrunch.count', -1) do
      delete :destroy, id: @calf_crunch
    end

    assert_redirected_to calf_crunches_path
  end
end
