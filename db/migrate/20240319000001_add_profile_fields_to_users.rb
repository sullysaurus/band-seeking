class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :instruments_played, :string, array: true, default: []
    add_column :users, :looking_for, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :instagram_handle, :string
    add_column :users, :website_url, :string
    add_column :users, :spotify_embed, :text
    add_column :users, :youtube_embed, :text
  end
end 