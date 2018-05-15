class CreateCorporations < ActiveRecord::Migration[5.2]
  def change
    create_table :corporations, id: false do |t|
      t.primary_key :id, :bigint, limit: 8, default: nil
      t.string :name
      t.string :description
      t.string :ticker
      t.belongs_to :alliance, foreign_key: true

      t.timestamps
    end
  end
end
