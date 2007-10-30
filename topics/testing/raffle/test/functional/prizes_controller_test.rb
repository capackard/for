require File.dirname(__FILE__) + '/../test_helper'
require 'prizes_controller'

# Re-raise errors caught by the controller.
class PrizesController; def rescue_action(e) raise e end; end

class PrizesControllerTest < Test::Unit::TestCase
  def setup
    @controller = PrizesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @raffle = raffles(:one)
  end

  def test_should_get_index
    get :index, :raffle_id => @raffle
    assert_response :success
    assert_not_nil assigns(:prizes)
  end

  def test_should_get_new
    get :new, :raffle_id => @raffle
    assert_response :success
  end

  def test_should_create_prize
    assert_difference('Prize.count') do
      post :create, :prize => { }, :raffle_id => @raffle, :raffle_id => @raffle
    end

    assert_redirected_to prize_path(assigns(:prize))
  end

  def test_should_show_prize
    get :show, :id => 1, :raffle_id => @raffle
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :raffle_id => @raffle
    assert_response :success
  end

  def test_should_update_prize
    put :update, :id => 1, :prize => { }, :raffle_id => @raffle
    assert_redirected_to prize_path(assigns(:prize))
  end

  def test_should_destroy_prize
    assert_difference('Prize.count', -1) do
      delete :destroy, :id => 1, :raffle_id => @raffle
    end

    assert_redirected_to prizes_path
  end
end
