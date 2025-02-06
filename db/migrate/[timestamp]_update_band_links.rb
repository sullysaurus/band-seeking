class UpdateBandLinks < ActiveRecord::Migration[7.0]
  def change
    remove_column :bands, :custom_links, :text
    add_column :bands, :instagram_handle, :string
    add_column :bands, :website_url, :string
    add_column :bands, :bandcamp_url, :string
  end
end 