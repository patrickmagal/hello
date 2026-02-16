# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Card do
  describe '#initialize' do
    context 'with valid input' do
      it 'parses a number card correctly' do
        card = Card.new('2H')
        expect(card.rank).to eq('2')
        expect(card.suit).to eq('H')
        expect(card.value).to eq(2)
      end

      it 'parses a Ten card correctly' do
        card = Card.new('TS')
        expect(card.rank).to eq('T')
        expect(card.suit).to eq('S')
        expect(card.value).to eq(10)
      end

      it 'parses a Jack card correctly' do
        card = Card.new('JD')
        expect(card.rank).to eq('J')
        expect(card.suit).to eq('D')
        expect(card.value).to eq(11)
      end

      it 'parses a Queen card correctly' do
        card = Card.new('QC')
        expect(card.rank).to eq('Q')
        expect(card.suit).to eq('C')
        expect(card.value).to eq(12)
      end

      it 'parses a King card correctly' do
        card = Card.new('KH')
        expect(card.rank).to eq('K')
        expect(card.suit).to eq('H')
        expect(card.value).to eq(13)
      end

      it 'parses an Ace card correctly' do
        card = Card.new('AS')
        expect(card.rank).to eq('A')
        expect(card.suit).to eq('S')
        expect(card.value).to eq(14)
      end

      it 'handles lowercase input by upcasing' do
        card = Card.new('ah')
        expect(card.rank).to eq('A')
        expect(card.suit).to eq('H')
        expect(card.value).to eq(14)
      end

      it 'parses all valid suits' do
        %w[H S D C].each do |suit|
          card = Card.new("A#{suit}")
          expect(card.suit).to eq(suit)
        end
      end

      it 'parses all valid ranks' do
        expected_values = {
          '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6,
          '7' => 7, '8' => 8, '9' => 9, 'T' => 10,
          'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14
        }

        expected_values.each do |rank, value|
          card = Card.new("#{rank}H")
          expect(card.rank).to eq(rank)
          expect(card.value).to eq(value)
        end
      end
    end

    context 'with invalid input' do
      it 'raises ArgumentError for nil input' do
        expect { Card.new(nil) }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for empty string' do
        expect { Card.new('') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for single character' do
        expect { Card.new('A') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for three characters' do
        expect { Card.new('AHH') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for invalid rank' do
        expect { Card.new('XH') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for invalid suit' do
        expect { Card.new('AX') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for numeric input' do
        expect { Card.new(42) }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for rank 0' do
        expect { Card.new('0H') }.to raise_error(ArgumentError)
      end

      it 'raises ArgumentError for rank 1' do
        expect { Card.new('1H') }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#to_s' do
    it 'returns the card as a two-character string' do
      card = Card.new('AH')
      expect(card.to_s).to eq('AH')
    end

    it 'returns consistent format for all cards' do
      card = Card.new('ts')
      expect(card.to_s).to eq('TS')
    end
  end

  describe '#inspect' do
    it 'returns a debug-friendly string representation' do
      card = Card.new('AH')
      expect(card.inspect).to include('Card')
      expect(card.inspect).to include('AH')
      expect(card.inspect).to include('14')
    end
  end

  describe 'constants' do
    it 'has VALUES constant with 13 entries' do
      expect(Card::VALUES.size).to eq(13)
    end

    it 'has VALUES constant that is frozen' do
      expect(Card::VALUES).to be_frozen
    end

    it 'has SUITS constant with 4 entries' do
      expect(Card::SUITS.size).to eq(4)
    end

    it 'maps Ace to 14' do
      expect(Card::VALUES['A']).to eq(14)
    end

    it 'maps King to 13' do
      expect(Card::VALUES['K']).to eq(13)
    end

    it 'maps Ten to 10' do
      expect(Card::VALUES['T']).to eq(10)
    end

    it 'maps 2 to 2' do
      expect(Card::VALUES['2']).to eq(2)
    end
  end
end
