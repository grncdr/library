class AddCoverToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :cover_file_name, :string
  end

  def self.down
    remove_column :books, :cover_file_name
  end
end
