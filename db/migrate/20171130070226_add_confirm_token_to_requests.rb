class AddConfirmTokenToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :confirm_token, :string
  end
end
