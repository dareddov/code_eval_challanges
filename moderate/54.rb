require 'rubygems'
require 'rspec'
require 'pry'

class Converter
  attr_accessor :rest_money

  TRANSFORMATIONS = {
      'ONE HUNDRED' => 100.00,
      'FIFTY' => 50.00,
      'TWENTY' => 20.00,
      'TEN' => 10.00,
      'FIVE' => 5.00,
      'TWO' => 2.00,
      'ONE' => 1.00,
      'HALF DOLLAR' => 0.50,
      'QUARTER' => 0.25,
      'DIME' => 0.10,
      'NICKEL' => 0.05,
      'PENNY' => 0.01,
}

  def initialize(rest_money)
    @rest_money = rest_money
  end

  def get_me_rest
    @bills = []
    @bills << 'ZERO' if rest_money == 0
    @bills << 'ERROR' if rest_money < 0
    TRANSFORMATIONS.each do |name, value|
      if value <= @rest_money
        count_bills = (@rest_money / value).to_i
        count_bills.times { @bills << name }
        @rest_money = (@rest_money - (value * count_bills)).round(2)
      end
    end
    @bills
  end
end

File.open(ARGV[0]).readlines.map do |line|
  to_pay, paid = line.strip.split(';').map(&:to_f)
  rest_money = (paid - to_pay).round(2)
  puts Converter.new(rest_money).get_me_rest.join(',')
end


describe Converter do
  context "return 0.05" do
    it do
      converter = Converter.new(0.05)
      expect(converter.get_me_rest).to eq ['NICKEL']
    end
  end

  context "return 0.06" do
    it do
      converter = Converter.new(0.06)
      expect(converter.get_me_rest).to eq ['NICKEL', 'PENNY']
    end
  end

  context "return 0.2" do
    it do
      converter = Converter.new(0.2)
      expect(converter.get_me_rest).to eq ['DIME', 'DIME']
    end
  end


  context "return 0.52" do
    it do
      converter = Converter.new(0.52)
      expect(converter.get_me_rest).to eq ['HALF DOLLAR', 'PENNY', 'PENNY']
    end
  end

  context "return ERROR" do
    it do
      converter = Converter.new(-1)
      expect(converter.get_me_rest).to eq ['ERROR']
    end
  end

  context "return ZERO" do
    it do
      converter = Converter.new(0)
      expect(converter.get_me_rest).to eq ['ZERO']
    end
  end
end
