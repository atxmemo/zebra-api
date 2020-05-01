require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "A game can be successfully created" do
    post '/games'
    assert_response :created
  end

  test "A game can be successfully fetched" do
    game_id = Game.create.id
    get "/games/#{game_id}"
    assert_response :created
  end
end
