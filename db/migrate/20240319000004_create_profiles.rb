class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :bio
      t.string :influences, array: true, default: []
      t.string :genres, array: true, default: []
      t.string :experience_level
      t.string :commitment_level
      t.integer :age
      t.string :gender
      t.string :availability
      t.string :transportation
      t.string :preferred_genres, array: true, default: []
      t.string :practice_frequency
      t.string :gig_frequency
      t.boolean :willing_to_travel
      t.integer :travel_distance
      t.string :equipment
      t.text :additional_notes

      t.timestamps
    end

    add_index :profiles, :genres, using: 'gin'
    add_index :profiles, :preferred_genres, using: 'gin'
    add_index :profiles, :influences, using: 'gin'
  end
end 