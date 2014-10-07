require_relative '../game'

describe Game do
  subject (:game)   { Game.new }

  its (:size) { STDIN.gets.chomp.should eq("1") }
end
