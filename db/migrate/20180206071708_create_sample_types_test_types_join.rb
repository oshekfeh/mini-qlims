class CreateSampleTypesTestTypesJoin < ActiveRecord::Migration[5.1]
  def up
    create_table :sample_types_test_types, :id => false do |t|
      t.integer "sample_type_id"
      t.integer "test_type_id"
    end
    add_index("sample_types_test_types", ["sample_type_id", "test_type_id"], :unique => true, :name => "my_index")
  end

  def down
    drop_table :sample_types_test_types
  end
end
