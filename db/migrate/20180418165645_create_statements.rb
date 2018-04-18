class CreateStatements < ActiveRecord::Migration[5.2]
  def change
    create_table :statements do |t|
      t.string :text
      t.boolean :nice

      t.timestamps
    end
  end
end
