class ConvertSeekingInstrumentsToArray < ActiveRecord::Migration[7.1]
  def up
    # Temporarily rename the old column
    rename_column :bands, :seeking_instruments, :seeking_instruments_old
    
    # Create new array column
    add_column :bands, :seeking_instruments, :string, array: true, default: []
    
    # Copy data from old to new, handling the conversion
    Band.reset_column_information
    Band.find_each do |band|
      if band.seeking_instruments_old.present?
        # Convert the string to an array, handling both comma-separated and existing array formats
        instruments = band.seeking_instruments_old.is_a?(String) ? 
          band.seeking_instruments_old.split(/,\s*/) : 
          band.seeking_instruments_old
        band.update_column(:seeking_instruments, instruments)
      end
    end
    
    # Remove old column
    remove_column :bands, :seeking_instruments_old
  end

  def down
    change_column :bands, :seeking_instruments, :text
  end
end 