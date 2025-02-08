class CreateBandsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :bands do |t|
      t.string :name, null: false
      t.string :city
      t.string :state
      t.string :band_type
      t.string :slug
      t.string :instagram_handle
      t.string :website_url
      t.string :bandcamp_url
      t.string :spotify_url
      t.string :songkick_id
      t.string :bandsintown_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :bands, :slug, unique: true
  end
end 