# frozen_string_literal: true

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
class TournamentSetting < ApplicationRecord
  validates :key, uniqueness: :true,
                  presence: true
  validates :value, presence: true

  DEFAULTS = {
    'max_speaks' => 28,
    'min_speaks' => 22,
    'rounds' => 5,
    'current_round' => 1,
    'punish_forfeits' => 0
  }.freeze

  def self.get(key)
    return nil unless exists?(key: key) || DEFAULTS[key]
    exists?(key: key) ? find_by(key: key).value : DEFAULTS[key]
  end

  def self.set(key, val)
    if exists?(key: key)
      setting = find_by(key: key)
      setting.value = val
      setting.save!
    else
      TournamentSetting.create(key: key, value: val)
    end
  end

  def self.get_bool(key)
    val = get(key)
    raise ArgumentError, 'Setting is not a boolean' if val != 0 && val != 1
    val == 1
  end
end
