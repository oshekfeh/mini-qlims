class CreateSamples < ActiveRecord::Migration[5.1]
  def change
    create_table :samples do |t|
      t.string :name
      t.integer :qty
      t.references :request, foreign_key: true
      t.references :test_type, foreign_key: true
      t.references :sample_type, foreign_key: true
      t.references :unit, foreign_key: true

      t.timestamps
    end
  end
end
