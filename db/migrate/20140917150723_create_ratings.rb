class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :rated_type
      t.integer :rater_id
      t.integer :rated_id
      t.integer :rating

      t.timestamps
    end
  end
end
