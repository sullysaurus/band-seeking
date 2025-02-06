class AddGigWidgetsToBands < ActiveRecord::Migration[7.0]
  def change
    add_column :bands, :songkick_id, :string
    add_column :bands, :bandsintown_id, :string
  end
end 