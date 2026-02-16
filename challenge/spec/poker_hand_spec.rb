# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PokerHand do
  # =========================================================================
  # Input Validation
  # =========================================================================
  describe '#initialize' do
    context 'with valid input' do
      it 'accepts a valid 5-card hand string' do
        expect { PokerHand.new('AH KH QH JH TH') }.not_to raise_error
      end

      it 'parses exactly 5 cards' do
        hand = PokerHand.new('2H 3D 4S 5C 6H')
        expect(hand.cards.size).to eq(5)
      end

      it 'handles lowercase input' do
        expect { PokerHand.new('ah kh qh jh th') }.not_to raise_error
      end
    end

    context 'with invalid input' do
      it 'raises ArgumentError for nil input' do
        expect { PokerHand.new(nil) }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for numeric input' do
        expect { PokerHand.new(12345) }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for empty string' do
        expect { PokerHand.new('') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for less than 5 cards' do
        expect { PokerHand.new('AH KH QH JH') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for more than 5 cards' do
        expect { PokerHand.new('AH KH QH JH TH 9H') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for duplicate cards' do
        expect { PokerHand.new('AH AH QH JH TH') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for invalid card format' do
        expect { PokerHand.new('AH KH QH JH XX') }.to raise_error(ArgumentError)
      end
    end
  end

  # =========================================================================
  # Royal Flush
  # =========================================================================
  describe '#evaluate' do
    context 'Royal Flush' do
      it 'detects royal flush in Hearts' do
        hand = PokerHand.new('AH KH QH JH TH')
        expect(hand.evaluate).to eq(:royal_flush)
      end

      it 'detects royal flush in Spades' do
        hand = PokerHand.new('AS KS QS JS TS')
        expect(hand.evaluate).to eq(:royal_flush)
      end

      it 'detects royal flush in Diamonds' do
        hand = PokerHand.new('AD KD QD JD TD')
        expect(hand.evaluate).to eq(:royal_flush)
      end

      it 'detects royal flush in Clubs' do
        hand = PokerHand.new('AC KC QC JC TC')
        expect(hand.evaluate).to eq(:royal_flush)
      end

      it 'detects royal flush regardless of card order' do
        hand = PokerHand.new('TH JH QH KH AH')
        expect(hand.evaluate).to eq(:royal_flush)
      end
    end

    # =========================================================================
    # Straight Flush
    # =========================================================================
    context 'Straight Flush' do
      it 'detects straight flush 9-K' do
        hand = PokerHand.new('9S TS JS QS KS')
        expect(hand.evaluate).to eq(:straight_flush)
      end

      it 'detects straight flush 5-9' do
        hand = PokerHand.new('5H 6H 7H 8H 9H')
        expect(hand.evaluate).to eq(:straight_flush)
      end

      it 'detects straight flush 2-6' do
        hand = PokerHand.new('2D 3D 4D 5D 6D')
        expect(hand.evaluate).to eq(:straight_flush)
      end

      it 'detects ace-low straight flush (A-2-3-4-5 same suit)' do
        hand = PokerHand.new('AH 2H 3H 4H 5H')
        expect(hand.evaluate).to eq(:straight_flush)
      end

      it 'detects straight flush regardless of card order' do
        hand = PokerHand.new('KS QS JS TS 9S')
        expect(hand.evaluate).to eq(:straight_flush)
      end
    end

    # =========================================================================
    # Four of a Kind
    # =========================================================================
    context 'Four of a Kind' do
      it 'detects four aces' do
        hand = PokerHand.new('AH AD AC AS 2C')
        expect(hand.evaluate).to eq(:four_of_a_kind)
      end

      it 'detects four kings' do
        hand = PokerHand.new('KH KD KC KS 3C')
        expect(hand.evaluate).to eq(:four_of_a_kind)
      end

      it 'detects four twos' do
        hand = PokerHand.new('2H 2D 2C 2S AH')
        expect(hand.evaluate).to eq(:four_of_a_kind)
      end

      it 'detects four of a kind with kicker at any position' do
        hand = PokerHand.new('7H 7D 7C 7S QH')
        expect(hand.evaluate).to eq(:four_of_a_kind)
      end
    end

    # =========================================================================
    # Full House
    # =========================================================================
    context 'Full House' do
      it 'detects aces full of kings' do
        hand = PokerHand.new('AH AD AC KH KS')
        expect(hand.evaluate).to eq(:full_house)
      end

      it 'detects kings full of aces' do
        hand = PokerHand.new('KH KD KC AH AS')
        expect(hand.evaluate).to eq(:full_house)
      end

      it 'detects twos full of threes' do
        hand = PokerHand.new('2H 2D 2C 3H 3S')
        expect(hand.evaluate).to eq(:full_house)
      end

      it 'detects full house regardless of card order' do
        hand = PokerHand.new('KS AH KD AC KH')
        expect(hand.evaluate).to eq(:full_house)
      end
    end

    # =========================================================================
    # Flush
    # =========================================================================
    context 'Flush' do
      it 'detects flush in Hearts' do
        hand = PokerHand.new('2H 7H 9H JH AH')
        expect(hand.evaluate).to eq(:flush)
      end

      it 'detects flush in Spades' do
        hand = PokerHand.new('3S 5S 8S TS KS')
        expect(hand.evaluate).to eq(:flush)
      end

      it 'detects flush in Diamonds' do
        hand = PokerHand.new('2D 4D 6D 8D TD')
        expect(hand.evaluate).to eq(:flush)
      end

      it 'detects flush in Clubs' do
        hand = PokerHand.new('3C 5C 7C 9C JC')
        expect(hand.evaluate).to eq(:flush)
      end

      it 'does not classify a straight flush as just a flush' do
        hand = PokerHand.new('5H 6H 7H 8H 9H')
        expect(hand.evaluate).not_to eq(:flush)
      end
    end

    # =========================================================================
    # Straight
    # =========================================================================
    context 'Straight' do
      it 'detects straight 5-9 with mixed suits' do
        hand = PokerHand.new('5H 6S 7D 8C 9H')
        expect(hand.evaluate).to eq(:straight)
      end

      it 'detects straight 2-6 with mixed suits' do
        hand = PokerHand.new('2S 3C 4S 5H 6D')
        expect(hand.evaluate).to eq(:straight)
      end

      it 'detects straight T-A (broadway) with mixed suits' do
        hand = PokerHand.new('TH JS QD KC AH')
        expect(hand.evaluate).to eq(:straight)
      end

      it 'detects ace-low straight (A-2-3-4-5) with mixed suits' do
        hand = PokerHand.new('AH 2S 3D 4C 5H')
        expect(hand.evaluate).to eq(:straight)
      end

      it 'detects straight regardless of card order' do
        hand = PokerHand.new('9H 7D 5H 8C 6S')
        expect(hand.evaluate).to eq(:straight)
      end

      it 'does not detect a wrap-around straight (Q-K-A-2-3)' do
        hand = PokerHand.new('QH KS AD 2C 3H')
        expect(hand.evaluate).not_to eq(:straight)
      end
    end

    # =========================================================================
    # Three of a Kind
    # =========================================================================
    context 'Three of a Kind' do
      it 'detects three queens' do
        hand = PokerHand.new('QH QD QC 2C 3H')
        expect(hand.evaluate).to eq(:three_of_a_kind)
      end

      it 'detects three aces' do
        hand = PokerHand.new('AH AD AC 3D 4H')
        expect(hand.evaluate).to eq(:three_of_a_kind)
      end

      it 'detects three twos' do
        hand = PokerHand.new('2H 2D 2C 5S 9H')
        expect(hand.evaluate).to eq(:three_of_a_kind)
      end

      it 'does not classify a full house as three of a kind' do
        hand = PokerHand.new('AH AD AC KH KS')
        expect(hand.evaluate).not_to eq(:three_of_a_kind)
      end
    end

    # =========================================================================
    # Two Pair
    # =========================================================================
    context 'Two Pair' do
      it 'detects aces and kings' do
        hand = PokerHand.new('AH AD KH KS 2C')
        expect(hand.evaluate).to eq(:two_pair)
      end

      it 'detects jacks and fives' do
        hand = PokerHand.new('JH JD 5C 5S 9H')
        expect(hand.evaluate).to eq(:two_pair)
      end

      it 'detects twos and threes' do
        hand = PokerHand.new('2H 2D 3C 3S AH')
        expect(hand.evaluate).to eq(:two_pair)
      end

      it 'detects two pair regardless of card order' do
        hand = PokerHand.new('KS 2C AH AD KH')
        expect(hand.evaluate).to eq(:two_pair)
      end
    end

    # =========================================================================
    # Pair
    # =========================================================================
    context 'Pair' do
      it 'detects pair of jacks' do
        hand = PokerHand.new('JH JD 2C 3H 4S')
        expect(hand.evaluate).to eq(:pair)
      end

      it 'detects pair of aces' do
        hand = PokerHand.new('AH AD 2C 3D 4H')
        expect(hand.evaluate).to eq(:pair)
      end

      it 'detects pair of twos' do
        hand = PokerHand.new('2H 2D 5C 8S KH')
        expect(hand.evaluate).to eq(:pair)
      end

      it 'does not classify two pair as a single pair' do
        hand = PokerHand.new('AH AD KH KS 2C')
        expect(hand.evaluate).not_to eq(:pair)
      end
    end

    # =========================================================================
    # High Card
    # =========================================================================
    context 'High Card' do
      it 'detects high card with J high' do
        hand = PokerHand.new('2S 4H 6D 8C JS')
        expect(hand.evaluate).to eq(:high_card)
      end

      it 'detects high card with 7 high' do
        hand = PokerHand.new('2S 3H 4D 5C 7S')
        expect(hand.evaluate).to eq(:high_card)
      end

      it 'detects high card with A high (non-flush, non-straight)' do
        hand = PokerHand.new('AH KH QH JH 2C')
        expect(hand.evaluate).to eq(:high_card)
      end

      it 'detects high card with mixed values' do
        hand = PokerHand.new('2H 5D 9C JS KH')
        expect(hand.evaluate).to eq(:high_card)
      end
    end

    # =========================================================================
    # Edge Cases
    # =========================================================================
    context 'Edge Cases' do
      it 'ace-low straight flush beats a flush' do
        hand = PokerHand.new('AH 2H 3H 4H 5H')
        expect(hand.evaluate).to eq(:straight_flush)
      end

      it 'ace-low straight with mixed suits is just a straight' do
        hand = PokerHand.new('AS 2H 3D 4C 5S')
        expect(hand.evaluate).to eq(:straight)
      end

      it 'broadway straight (T-A) with mixed suits is a straight, not royal flush' do
        hand = PokerHand.new('TH JS QD KC AS')
        expect(hand.evaluate).to eq(:straight)
      end

      it 'near-flush (4 of same suit + 1 different) is not a flush' do
        hand = PokerHand.new('2H 4H 6H 8H TS')
        expect(hand.evaluate).not_to eq(:flush)
      end

      it 'near-straight (4 consecutive + 1 gap) is not a straight' do
        hand = PokerHand.new('5H 6S 7D 8C TH')
        expect(hand.evaluate).not_to eq(:straight)
      end

      it 'full house is ranked higher than flush' do
        full_house = PokerHand.new('AH AD AC KH KS')
        expect(full_house.evaluate).to eq(:full_house)
      end

      it 'four of a kind is ranked higher than full house' do
        four_kind = PokerHand.new('AH AD AC AS KS')
        expect(four_kind.evaluate).to eq(:four_of_a_kind)
      end
    end

    # =========================================================================
    # Comprehensive classification check
    # =========================================================================
    context 'Complete hierarchy verification' do
      test_cases = {
        'AH KH QH JH TH' => :royal_flush,
        'AS KS QS JS TS' => :royal_flush,
        '9S TS JS QS KS' => :straight_flush,
        '5H 6H 7H 8H 9H' => :straight_flush,
        '2D 3D 4D 5D 6D' => :straight_flush,
        'AH 2H 3H 4H 5H' => :straight_flush,
        'AH AD AC AS 2C' => :four_of_a_kind,
        'KH KD KC KS 3C' => :four_of_a_kind,
        '2H 2D 2C 2S AH' => :four_of_a_kind,
        'AH AD AC KH KS' => :full_house,
        'KH KD KC AH AS' => :full_house,
        '2H 2D 2C 3H 3S' => :full_house,
        '2H 7H 9H JH AH' => :flush,
        '3S 5S 8S TS KS' => :flush,
        '5H 6S 7D 8C 9H' => :straight,
        '2S 3C 4S 5H 6D' => :straight,
        'AH 2S 3D 4C 5H' => :straight,
        'QH QD QC 2C 3H' => :three_of_a_kind,
        'AH AD AC 3D 4H' => :three_of_a_kind,
        'AH AD KH KS 2C' => :two_pair,
        'JH JD 5C 5S 9H' => :two_pair,
        'JH JD 2C 3H 4S' => :pair,
        'AH AD 2C 3D 4H' => :pair,
        '2S 4H 6D 8C JS' => :high_card,
        '2S 3H 4D 5C 7S' => :high_card,
      }

      test_cases.each do |hand_string, expected|
        it "classifies '#{hand_string}' as #{expected}" do
          hand = PokerHand.new(hand_string)
          expect(hand.evaluate).to eq(expected)
        end
      end
    end
  end

  # =========================================================================
  # #to_s
  # =========================================================================
  describe '#to_s' do
    it 'returns the hand as a space-separated string' do
      hand = PokerHand.new('AH KH QH JH TH')
      result = hand.to_s
      %w[AH KH QH JH TH].each do |card|
        expect(result).to include(card)
      end
    end
  end

  # =========================================================================
  # Helper data
  # =========================================================================
  describe 'helper attributes' do
    let(:hand) { PokerHand.new('AH KH QH JH TH') }

    it 'exposes cards array' do
      expect(hand.cards).to be_an(Array)
      expect(hand.cards.size).to eq(5)
      expect(hand.cards.first).to be_a(Card)
    end

    it 'exposes values array' do
      expect(hand.values).to be_an(Array)
      expect(hand.values.size).to eq(5)
      expect(hand.values).to all(be_a(Integer))
    end

    it 'exposes suits array' do
      expect(hand.suits).to be_an(Array)
      expect(hand.suits.size).to eq(5)
    end

    it 'exposes sorted_values' do
      expect(hand.sorted_values).to eq(hand.values.sort)
    end

    it 'exposes value_counts as a Hash' do
      expect(hand.value_counts).to be_a(Hash)
    end
  end
end
