require File.dirname(__FILE__) + '/../test_helper'
require 'raffles_controller'

# Re-raise errors caught by the controller.
class RafflesController; def rescue_action(e) raise e end; end

class RafflesControllerTest < Test::Unit::TestCase
  def setup
    @controller = RafflesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:raffles)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_raffle
    assert_difference('Raffle.count') do
      post :create, :raffle => { }
    end

    assert_redirected_to raffle_path(assigns(:raffle))
  end

  def test_should_show_raffle
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end

  def test_should_update_raffle
    put :update, :id => 1, :raffle => { }
    assert_redirected_to raffle_path(assigns(:raffle))
  end

  def test_should_destroy_raffle
    assert_difference('Raffle.count', -1) do
      delete :destroy, :id => 1
    end

    assert_redirected_to raffles_path
  end
end
