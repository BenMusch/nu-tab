# frozen_string_literal: true
class TournamentSettting
  DEFAULTS = {
    max_speaks: 28,
    min_speaks: 22,
    rounds: 5
  }.freeze

  def method_missing(method_name, *arguments, &block)
    return DEFAULTS[method_name] if DEFAULTS[method_name]
    super
  end

  def respond_to_missing?(method_name, include_private=false)
    DEFAULTS.keys.include?(method_name) || super
  end
end
