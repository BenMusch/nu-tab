# frozen_string_literal: true
class TournamentSettting
  DEFAULTS = {
    max_speaks: 28,
    min_speaks: 22,
    rounds: 5
  }

  def method_missing(method_name, *arguments, &block)
    return DEFAULTS[method_name] if DEFAULTS[method_name]
    super
  end
end
