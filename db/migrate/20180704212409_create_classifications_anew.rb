class CreateClassificationsAnew < ActiveRecord::Migration[5.2]
  def change
    create_table :classifications do |t|
      t.references :label, foreign_key: true
      t.references :reporter, foreign_key: true
      t.references :statement, foreign_key: true

      t.timestamps
    end
  end
end
