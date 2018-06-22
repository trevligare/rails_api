class ClassfiyMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :statements, :classification, foreign_key: true
    remove_column :statements, :nice, :boolean
  end
end
