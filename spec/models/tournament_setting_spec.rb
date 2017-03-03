# == Schema Information
#
# Table name: tournament_settings
#
#  id         :integer          not null, primary key
#  key        :string
#  value      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe TournamentSetting, type: :model do
  let(:setting) { build(:tournament_setting, key: 'key', value: 10) }

  context 'validation' do
    before do
      expect(setting).to be_valid
    end

    describe 'key' do
      it 'is present' do
        setting.key = nil
        expect(setting).not_to be_valid
      end

      it 'is unique' do
        create(:tournament_setting, key: setting.key, value: 1)
        expect(setting).not_to be_valid
      end
    end

    describe 'value' do
      it 'is present' do
        setting.value = nil
        expect(setting).not_to be_valid
      end
    end
  end

  describe '#get' do
    context 'when a setting with the key exists' do
      it 'returns the value' do
        setting.save!
        expect(TournamentSetting.get(setting.key)).to eq setting.value
      end
    end

    context "when a setting with the doesn't exist, but a default does" do
      it 'returns the default value' do
        expect(TournamentSetting.get('max_speaks')).to eq TournamentSetting::DEFAULTS['max_speaks']
        expect(TournamentSetting.exists?(key: 'max_speaks')).to be false
      end
    end

    context 'when no setting or default exists with the key' do
      it 'returns nil' do
        expect(TournamentSetting.get('random_val')).to be nil
      end
    end
  end

  describe '#set' do
    context 'when there is no setting with the key' do
      it 'creates a TournamentSetting' do
        expect(TournamentSetting.get('setting')).to be nil
        TournamentSetting.set('setting', 10)
        expect(TournamentSetting.get('setting')).to be 10
      end
    end

    context 'when there is a setting with the key' do
      it 'updates the setting' do
        create(:tournament_setting, key: 'setting', value: 15)
        expect(TournamentSetting.get('setting')).to be 15
        TournamentSetting.set('setting', 10)
        expect(TournamentSetting.get('setting')).to be 10
      end
    end
  end

  describe '#get_bool' do
    context 'when the setting is not 0 or 1' do
      it 'raises an error' do
        expect{ TournamentSetting.get_bool('invalid') }.to raise_error(ArgumentError)

        TournamentSetting.set('key', 2)
        expect{ TournamentSetting.get_bool('key') }.to raise_error(ArgumentError)
      end
    end

    context 'when the setting is 1' do
      it 'returns true' do
        TournamentSetting.set('key', 1)
        expect(TournamentSetting.get_bool('key')).to be true
      end
    end

    context 'when the setting is 0' do
      it 'returns false' do
        TournamentSetting.set('key', 0)
        expect(TournamentSetting.get_bool('key')).to be false
      end
    end
  end
end
