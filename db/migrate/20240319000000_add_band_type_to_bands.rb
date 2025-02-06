class AddBandTypeToBands < ActiveRecord::Migration[7.1]
  def change
    add_column :bands, :band_type, :string
  end
end 