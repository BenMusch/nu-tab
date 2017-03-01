# frozen_string_literal: true
module CheckInnable
  extend ActiveSupport::Concern

  included do
    has_many :check_ins, as: :check_innable
  end
end
