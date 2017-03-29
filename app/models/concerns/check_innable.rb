# frozen_string_literal: true
module CheckInnable
  extend ActiveSupport::Concern

  included do
    has_many :check_ins, as: :check_innable

    def self.checked_in(round_number)
      where(id: CheckIn.select(:subject_id).
                        where(round_number: round_number, subject_type: table_name.singularize.capitalize))
    end
  end


  def checked_in_for_round?(round_number)
    CheckIn.exists?(subject: self, round_number: round_number)
  end

  def check_in_for_round!(round_number)
    CheckIn.create(subject: self, round_number: round_number)
  end

  def check_out_for_round!(round_number)
    CheckIn.where(subject: self, round_number: round_number).destroy_all
  end
end
