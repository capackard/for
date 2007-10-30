require File.dirname(__FILE__) + '/../test_helper'
require 'participants_controller'

# Re-raise errors caught by the controller.
class ParticipantsController; def rescue_action(e) raise e end; end

class ParticipantsControllerTest < Test::Unit::TestCase
  def setup
    @controller = ParticipantsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @raffle = raffles(:one)
  end

  def test_should_get_index
    get :index, :raffle_id => @raffle
    assert_response :success
    assert_not_nil assigns(:participants)
  end

  def test_should_get_new
    get :new, :raffle_id => @raffle
    assert_response :success
  end

  def test_should_create_participant
    assert_difference('Participant.count') do
      post :create, :participant => { }, :raffle_id => @raffle
    end

    assert_redirected_to raffle_participant_path(@raffle, assigns(:participant))
  end

  def test_should_show_participant
    get :show, :id => 1, :raffle_id => @raffle
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1, :raffle_id => @raffle
    assert_response :success
  end

  def test_should_update_participant
    put :update, :id => 1, :participant => { }, :raffle_id => @raffle
    assert_redirected_to raffle_participant_path(@raffle, assigns(:participant))
  end

  def test_should_destroy_participant
    assert_difference('Participant.count', -1) do
      delete :destroy, :id => 1, :raffle_id => @raffle
    end

    assert_redirected_to raffle_participants_path(@raffle)
  end
end
