class CreateBands < ActiveRecord::Migration[7.0]
  def change
    create_table :bands do |t|
      t.string :name, null: false
      t.string :city
      t.string :state
      t.string :seeking_instruments, array: true, default: []
      t.string :genre
      t.string :commitment_level
      t.string :practice_frequency
      t.string :gig_frequency
      t.string :originals_to_covers_ratio
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :bands, :name
    add_index :bands, :seeking_instruments, using: :gin
  end
end