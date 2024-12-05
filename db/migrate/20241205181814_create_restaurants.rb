class CreateRestaurants < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :city
      t.string :status

      t.timestamps
    end
  end
end
