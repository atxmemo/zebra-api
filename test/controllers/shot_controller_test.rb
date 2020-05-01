require 'test_helper'

class ShotControllerTest < ActionDispatch::IntegrationTest
  test "A shot can be successfully created" do
    game = Game.create
    valid_knocked_pins = rand(11)
    post "/games/#{game.id}/shots", params: { knocked_pins: valid_knocked_pins }
    assert_response :created
  end

  test "A shot with invalid knocked pins will not be created" do
    game = Game.create
    invalid_knocked_pins = 11
    post "/games/#{game.id}/shots", params: { knocked_pins: invalid_knocked_pins }
    assert_response :unprocessable_entity
    assert_equal JSON.parse(body)['error'], 'Invalid amount of knocked pins for a shot'
  end
end
