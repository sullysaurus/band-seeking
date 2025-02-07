class FixSeekingInstrumentsArray < ActiveRecord::Migration[7.1]
  def up
    # First, ensure the column is text
    change_column :bands, :seeking_instruments, :text
    
    # Then convert it to an array
    change_column :bands, :seeking_instruments, :string, array: true, default: [], using: "(string_to_array(seeking_instruments, ','))"
  end

  def down
    change_column :bands, :seeking_instruments, :text
  end
end 