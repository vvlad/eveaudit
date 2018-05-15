# frozen_string_literal: true

class CreateAudits < ActiveRecord::Migration[5.2]
  def change
    create_table :audits do |t|
      t.belongs_to :character, foreign_key: true
      t.string :key

      t.timestamps
    end
  end
end
