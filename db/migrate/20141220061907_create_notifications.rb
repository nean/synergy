class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.boolean :seen, default: false
      t.integer :activity_id

      t.timestamps
    end
  end
end
