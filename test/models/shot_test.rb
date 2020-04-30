require 'test_helper'

class ShotTest < ActiveSupport::TestCase
  test "A shot is valid between 0 and 10" do
    begin
      11.times { |i| Game.create.add_shot(i) }
    rescue
      fail 'Invalid shot'
    end
  end

  test "A shot is invalid between if greater than 10" do
    assert_raise ArgumentError do
      Game.create.add_shot(10 + rand(1..100))
    end
  end
end
