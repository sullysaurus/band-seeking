class FixSeekingInstrumentsColumnType < ActiveRecord::Migration[7.1]
  def up
    # First remove the existing column
    remove_column :bands, :seeking_instruments

    # Add it back with the correct array type
    add_column :bands, :seeking_instruments, :text, array: true, default: []
    
    # Re-add the index
    add_index :bands, :seeking_instruments, using: 'gin'
  end

  def down
    remove_column :bands, :seeking_instruments
    add_column :bands, :seeking_instruments, :text
  end
end 