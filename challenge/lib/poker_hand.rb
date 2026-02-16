# frozen_string_literal: true

require_relative 'card'

class PokerHand
  attr_reader :cards, :values, :suits, :sorted_values, :value_counts

  def initialize(hand_string)
    # TODO: validar a entrada e criar os objetos Card.
    # Consulte os testes em spec/poker_hand_spec.rb para entender o comportamento esperado.
  end

  # Avalia a mao e retorna a classificacao como Symbol.
  # Classificacoes possiveis (da maior para a menor):
  #   :royal_flush, :straight_flush, :four_of_a_kind, :full_house,
  #   :flush, :straight, :three_of_a_kind, :two_pair, :pair, :high_card
  def evaluate
    # TODO: implementar
    :high_card
  end

  def to_s
    # TODO: implementar
  end

  private

  # TODO: crie os metodos auxiliares que achar necessario
end
