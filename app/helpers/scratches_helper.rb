# frozen_string_literal: true
module ScratchesHelper
  def judge_page?
    @entity && @entity.class == Judge
  end
end
