class AddPositionToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :position, :integer
  end
end
