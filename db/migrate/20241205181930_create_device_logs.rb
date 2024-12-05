class CreateDeviceLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :device_logs do |t|
      t.references :device, null: false, foreign_key: true
      t.string :change

      t.timestamps
    end
  end
end
