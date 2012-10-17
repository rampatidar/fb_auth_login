class AddFbidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_id, :string
    add_column :users, :token, :string
  end
end
