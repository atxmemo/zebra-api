require 'test_helper'

class FrameTest < ActiveSupport::TestCase

  test "An open frame is scored at face value" do
    game = Game.create
    shot_1 = rand(5)
    shot_2 = rand(5)

    game.add_shot(shot_1)
    game.add_shot(shot_2)

    assert_equal game.frames.last.score, shot_1 + shot_2
  end

  test "An open frame has a limited acceptable shot value on the second shot" do
    game = Game.create
    shot_1 = rand(10)

    # Make this shot an invalid number
    shot_2 = 11 - shot_1

    game.add_shot(shot_1)

    assert_raise ArgumentError do
      game.add_shot(shot_2)
    end
  end

  test "A spare frame is not scored until the following roll" do
    game = Game.create
    shot_1 = rand(5)

    # Make this frame a spare
    shot_2 = 10 - shot_1

    game.add_shot(shot_1)
    game.add_shot(shot_2)

    assert_nil game.frames.last.score
  end

  test "A spare frame is scored following a roll" do
    game = Game.create
    shot_1 = rand(5)

    # Make this frame a spare
    shot_2 = 10 - shot_1

    shot_3 = rand(0...11)

    game.add_shot(shot_1)
    game.add_shot(shot_2)
    game.add_shot(shot_3)

    assert_equal game.frames.first.score, shot_1 + shot_2 + shot_3
  end

  test "A strike frame is not scored until the following two rolls" do
    game = Game.create

    # Make this frame a strike
    shot_1 = 10

    game.add_shot(shot_1)

    assert_nil game.frames.first.score

    shot_2 = rand(0...11)
    game.add_shot(shot_2)

    assert_nil game.frames.first.score
  end

  test "A strike frame scored following two rolls" do
    game = Game.create

    # Make this frame a strike
    shot_1 = 10

    game.add_shot(shot_1)

    shot_2 = rand(0...5)
    game.add_shot(shot_2)

    shot_3 = rand(0...5)
    game.add_shot(shot_3)

    assert_equal game.frames.first.score, shot_1 + shot_2 + shot_3
  end
end
