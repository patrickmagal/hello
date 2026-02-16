# frozen_string_literal: true

require_relative '../lib/card'
require_relative '../lib/poker_hand'

RSpec.configure do |config|
  config.formatter = :documentation
  config.color = true
  config.order = :defined
end
