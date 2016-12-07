class AddColumnToArtists < ActiveRecord::Migration[5.0]
  def change
    add_column :artists, :styles, :string
  end
end
