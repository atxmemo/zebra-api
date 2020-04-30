require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "Initial frame is available" do
    game = Game.create
    game.current_frame

    assert game.current_frame.available?
  end

  test "Once we are on the last frame, we should not add a new fame to the game" do
    game = Game.create

    10.times {
      first_shot = rand(5)
      second_shot = rand(5)

      game.add_shot(first_shot)
      game.add_shot(second_shot)
    }

    assert_equal game.frames.last, game.current_frame
  end

  test "A game has score constantly updated (only open frames scenario)" do
    game = Game.create

    score = 0
    10.times {
      first_shot = rand(5)
      second_shot = rand(5)

      score = score + first_shot + second_shot

      game.add_shot(first_shot)
      game.add_shot(second_shot)

      assert_equal game.score, score
    }
  end

  test "A game has score constantly updated (only spare frames scenario)" do
    game = Game.create

    21.times {
      first_shot = rand(10)
      second_shot = 10 - first_shot

      game.add_shot(first_shot)
      game.add_shot(second_shot)

      assert_equal game.score, game.frames.pluck(:score).compact.reduce(0, :+)
    }
  end

  test "A game has score constantly updated (only strikes frames scenario)" do
    game = Game.create

    STRIKE_SCORE = 10
    PERFECT_SCORE = 300

    12.times {
      game.add_shot(STRIKE_SCORE)
    }

    assert_equal game.score, PERFECT_SCORE
  end

end
