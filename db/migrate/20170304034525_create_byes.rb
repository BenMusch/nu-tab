class CreateByes < ActiveRecord::Migration[5.0]
  def change
    create_table :byes do |t|
      t.references :team, foreign_key: true
      t.integer :round_number

      t.timestamps
    end
  end
end
