# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications, id: false do |t|
      t.primary_key :id, :integer, limit: 8
      t.belongs_to :character, foreign_key: true
      t.integer :sender_id, :integer, limit: 8
      t.string :sender_type, null: false
      t.index %i[sender_id sender_type]
      t.string :text
      t.string :kind

      t.timestamps
    end
  end
end
