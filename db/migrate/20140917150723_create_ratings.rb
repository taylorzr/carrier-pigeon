class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :for_type
      t.integer :rating_user_id
      t.integer :rated_user_id
      t.integer :rating

      t.timestamps
    end
  end
end
