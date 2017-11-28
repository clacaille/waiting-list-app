class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.string :biography, null: false
      t.boolean :accepted, default: false
      t.boolean :confirmed, default: false
      t.boolean :expired, default: false

      t.timestamps
    end
  end
end
