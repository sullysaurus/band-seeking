class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :username, null: false
      t.string :city
      t.string :state
      t.string :instruments_played, array: true, default: []
      t.string :experience_level
      t.boolean :availability, default: true
      t.string :looking_for
      t.string :aspirations
      t.string :spotify_link
      t.string :youtube_link
      t.string :instagram_link
      t.string :website_url

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :username, unique: true
    add_index :users, :instruments_played, using: :gin
  end
end 