# frozen_string_literal: true

class AddDefaultValuesForFieldsInCorprations < ActiveRecord::Migration[5.2]
  def change
    change_column :corporations, :name, :string, default: "Unkwnon"
  end
end
