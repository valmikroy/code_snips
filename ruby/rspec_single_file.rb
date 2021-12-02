# Credit https://justincypret.com/blog/running-and-testing-a-single-ruby-file
require "rspec/autorun"

class Dice

  def initialize(count = 2)
    @count = count
  end

  def roll
    1.upto(@count).reduce(0) {|sum| sum += rand(1..6) }
  end
end

describe Dice, ".roll" do
  it "it returns random total within expected range" do
    total = Dice.new(2).roll
    expect(total).to be_between(2, 12)
  end
end
