class AddStatusToDevice < ActiveRecord::Migration[7.2]
  def change
    add_column :devices, :status, :string
  end
end
