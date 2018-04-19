class CreateReporters < ActiveRecord::Migration[5.2]
  def change
    create_table :reporters do |t|
      t.string :uuid
      t.references :source, foreign_key: true

      t.timestamps
    end
  end
end
