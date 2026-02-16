# frozen_string_literal: true

class Card
  VALUES = {
    '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
    '7' => 7, '8' => 8, '9' => 9, 'T' => 10,
    'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14
  }.freeze

  SUITS = %w[H S D C].freeze

  attr_reader :rank, :suit, :value

  def initialize(card_string)
    validate_and_parse!(card_string)
  end

  def to_s
    "#{rank}#{suit}"
  end

  def inspect
    "#<Card #{self} (value: #{value})>"
  end

  private

  def validate_and_parse!(card_string)
    unless card_string.is_a?(String) && card_string.length == 2
      raise ArgumentError, "Card must be a 2-character string, got: #{card_string.inspect}"
    end

    @rank = card_string[0].upcase
    @suit = card_string[1].upcase

    unless VALUES.key?(@rank)
      raise ArgumentError, "Invalid rank: #{@rank}. Valid: #{VALUES.keys.join(', ')}"
    end

    unless SUITS.include?(@suit)
      raise ArgumentError, "Invalid suit: #{@suit}. Valid: #{SUITS.join(', ')}"
    end

    @value = VALUES.fetch(@rank)
  end
end
