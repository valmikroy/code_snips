# Credit https://justincypret.com/blog/running-and-testing-a-single-ruby-file
require "rspec/autorun"

class GroupingFormatter
  RSpec::Core::Formatters.register self, :dump_summary, :close, :example_failed, :example_passed


  def initialize(output)
    @output = output
  end

  def example_failed(notification)
    e = notification.example
    @output << "FAILED #{e.full_description}\n"
  end  

  def example_passed(notification)
    @output << "OK #{notification.example.full_description}\n"
  end

  def dump_summary(_notification)
    @output << ''
  end

  def close(_notification)
    @output << "\n"
  end


end


RSpec.configure do |c|
  c.formatter = GroupingFormatter
  c.color = true
end




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
