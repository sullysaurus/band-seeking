class AddSeekingInstrumentsToBands < ActiveRecord::Migration[7.1]
  def change
    add_column :bands, :seeking_instruments, :text, array: true, default: []
    add_index :bands, :seeking_instruments, using: 'gin'
  end
end 