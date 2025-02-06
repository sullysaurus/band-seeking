class CreateBands < ActiveRecord::Migration[7.0]
  def change
    create_table :bands do |t|
      t.string :name
      t.string :city
      t.string :state
      t.text :seeking_instruments
      t.text :custom_links
      t.string :spotify_url
      t.string :youtube_url
      t.string :slug
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bands, :slug, unique: true
  end
end 