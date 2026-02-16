# frozen_string_literal: true

require_relative 'card'

class PokerHand
  attr_reader :cards, :values, :suits, :sorted_values, :value_counts

  def initialize(hand_string)
    validate_input!(hand_string)
    @cards = parse_cards(hand_string)
    @values = @cards.map(&:value)
    @suits = @cards.map(&:suit)
    @sorted_values = @values.sort
    @value_counts = calculate_value_counts
  end

  def evaluate
    return :royal_flush     if royal_flush?
    return :straight_flush  if straight_flush?
    return :four_of_a_kind  if four_of_a_kind?
    return :full_house      if full_house?
    return :flush           if flush?
    return :straight        if straight?
    return :three_of_a_kind if three_of_a_kind?
    return :two_pair        if two_pair?
    return :pair            if pair?

    :high_card
  end

  def to_s
    cards.map(&:to_s).join(' ')
  end

  private

  def validate_input!(hand_string)
    unless hand_string.is_a?(String)
      raise ArgumentError, "Input must be a String, got: #{hand_string.class}"
    end

    card_strings = hand_string.split
    unless card_strings.length == 5
      raise ArgumentError, "Hand must contain exactly 5 cards, got: #{card_strings.length}"
    end

    unique_cards = card_strings.map(&:upcase).uniq
    unless unique_cards.length == 5
      raise ArgumentError, "Hand contains duplicate cards: #{hand_string}"
    end
  end

  def parse_cards(hand_string)
    hand_string.split.map { |cs| Card.new(cs) }
  end

  def calculate_value_counts
    @values.tally.sort_by { |value, count| [-count, -value] }.to_h
  end

  # --- Classification helpers ---

  def flush?
    @suits.uniq.size == 1
  end

  def straight?
    consecutive?(@sorted_values) || ace_low_straight?
  end

  def consecutive?(vals)
    vals.each_cons(2).all? { |a, b| b == a + 1 }
  end

  def ace_low_straight?
    @sorted_values == [2, 3, 4, 5, 14]
  end

  def royal_flush?
    straight_flush? && @sorted_values == [10, 11, 12, 13, 14]
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    @value_counts.values.include?(4)
  end

  def full_house?
    @value_counts.values.sort == [2, 3]
  end

  def three_of_a_kind?
    @value_counts.values.include?(3) && !full_house?
  end

  def two_pair?
    @value_counts.values.count(2) == 2
  end

  def pair?
    @value_counts.values.include?(2) && @value_counts.values.count(2) == 1
  end
end
