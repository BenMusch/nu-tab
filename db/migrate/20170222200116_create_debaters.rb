class CreateDebaters < ActiveRecord::Migration[5.0]
  def change
    create_table :debaters do |t|
      t.string :name
      t.boolean :novice
      t.belongs_to :school, foreign_key: true

      t.timestamps
    end
  end
end
