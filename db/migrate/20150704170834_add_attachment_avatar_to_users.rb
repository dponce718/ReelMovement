class AddAttachmentAvatarToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
    	t.integer :user_id
      t.attachment :avatar
    end
  end

  add_index :users, :user_id
  add_attachment :users, :avatar

  def self.down
    remove_attachment :users, :avatar
  end
end
