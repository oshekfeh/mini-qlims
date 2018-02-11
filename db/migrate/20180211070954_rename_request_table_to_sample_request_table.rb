class RenameRequestTableToSampleRequestTable < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :requests, :sample_requests
  end

  def self.down
    rename_table :sample_requests, :requests
  end
end
