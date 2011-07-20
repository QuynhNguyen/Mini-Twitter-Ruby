class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    #add index method, users is the table name
    add_index :users, :email, :unique => true
  end

  def self.down
    remove_index :users, :email
  end
end

