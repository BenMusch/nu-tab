class ChangeTypeToScratchType < ActiveRecord::Migration[5.0]
  def change
    rename_column :scratches, :type, :scratch_type
  end
end
