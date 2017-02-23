class CreateProtections < ActiveRecord::Migration[5.0]
  def change
    create_table :protections do |t|
      t.belongs_to :team, foreign_key: true
      t.belongs_to :school, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
