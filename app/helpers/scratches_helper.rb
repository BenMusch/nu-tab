module ScratchesHelper
  def judge_page?
    @entity && @entity.class == Judge
  end
end
