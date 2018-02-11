class RenameRequestIdColumnToSampleRequestId < ActiveRecord::Migration[5.1]
  def up
    rename_column :samples, :request_id, :sample_request_id
  end

  def down
    rename_column :samples, :sample_request_id, :request_id
  end
end
