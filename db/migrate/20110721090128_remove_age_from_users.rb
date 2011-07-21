class RemoveAgeFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :age
  end

  def self.down
    add_column :users, :age, :integer
  end
end
