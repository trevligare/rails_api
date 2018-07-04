class RenameClassificationsToLabels < ActiveRecord::Migration[5.2]
  def change
    remove_reference :statements, :classification, foreign_key: true
    rename_table :classifications, :labels
    # We are not adding label reference since it needs to become its own model
  end
end
