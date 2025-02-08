class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Profile fields
      t.string :username
      t.string :city
      t.string :state
      t.string :instruments_played, array: true, default: []
      t.string :looking_for
      t.string :instagram_handle
      t.string :website_url
      t.text :spotify_embed
      t.text :youtube_embed

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :username,             unique: true
    add_index :users, :instruments_played,    using: 'gin'
  end
end