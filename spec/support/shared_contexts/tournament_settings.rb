# frozen_string_literal: true
RSpec.shared_context 'with a punitive forfeit policy' do
  before do
    TournamentSetting.set('punish_forfeits', 1)
  end

  after do
    TournamentSetting.set('punish_forfeits', 0)
  end
end
