class CreateDevices < ActiveRecord::Migration[7.2]
  def change
    create_table :devices do |t|
      t.references :restaurant, null: false, foreign_key: true
      t.string :name
      t.string :device_type
      t.datetime :last_maintenance_at

      t.timestamps
    end
  end
end
