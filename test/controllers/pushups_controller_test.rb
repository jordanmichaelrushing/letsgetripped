require 'test_helper'

class PushupsControllerTest < ActionController::TestCase
  setup do
    @pushup = pushups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pushups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pushup" do
    assert_difference('Pushup.count') do
      post :create, pushup: { day_id: @pushup.day_id, set_one_reps: @pushup.set_one_reps, set_three_reps: @pushup.set_three_reps, set_two_reps: @pushup.set_two_reps, user_id: @pushup.user_id }
    end

    assert_redirected_to pushup_path(assigns(:pushup))
  end

  test "should show pushup" do
    get :show, id: @pushup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pushup
    assert_response :success
  end

  test "should update pushup" do
    patch :update, id: @pushup, pushup: { day_id: @pushup.day_id, set_one_reps: @pushup.set_one_reps, set_three_reps: @pushup.set_three_reps, set_two_reps: @pushup.set_two_reps, user_id: @pushup.user_id }
    assert_redirected_to pushup_path(assigns(:pushup))
  end

  test "should destroy pushup" do
    assert_difference('Pushup.count', -1) do
      delete :destroy, id: @pushup
    end

    assert_redirected_to pushups_path
  end
end
