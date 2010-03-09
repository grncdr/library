class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.integer :copies
      t.string :isbn
      t.string :title
      t.string :subtitle
      t.string :author
      t.text :summary
      t.string :publisher
      t.string :edition
      t.string :details

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
