class CreateCheckIns < ActiveRecord::Migration[5.0]
  def change
    create_table :check_ins do |t|
      t.integer :round_number
      t.belongs_to :subject, polymorphic: true, index: { name: 'index_subjects' }

      t.timestamps
    end
  end
end
