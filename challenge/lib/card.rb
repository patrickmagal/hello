# frozen_string_literal: true

class Card
  # Mapeie os caracteres de rank para seus valores numericos.
  # Consulte o README para ver os valores e naipes validos.
  VALUES = {
    # TODO: implementar
  }.freeze

  SUITS = %w[H S D C].freeze

  attr_reader :rank, :suit, :value

  def initialize(card_string)
    # TODO: validar e fazer o parse da string.
    # Consulte os testes em spec/card_spec.rb para entender o comportamento esperado.
  end

  def to_s
    # TODO: implementar
  end

  def inspect
    # TODO: implementar
  end
end
