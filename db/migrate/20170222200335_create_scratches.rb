class CreateScratches < ActiveRecord::Migration[5.0]
  def change
    create_table :scratches do |t|
      t.belongs_to :team, foreign_key: true
      t.belongs_to :judge, foreign_key: true
      t.integer :type

      t.timestamps
    end
  end
end
