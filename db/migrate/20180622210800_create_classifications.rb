class CreateClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :classifications do |t|
      t.string :name
      t.string :slug
      t.boolean :nice

      t.timestamps
    end
  end
end
