class CreateAlliances < ActiveRecord::Migration[5.2]
  def change
    create_table :alliances, id: false do |t|
      t.primary_key :id, :bigint, limit: 8, default: nil
      t.string :name

      t.timestamps
    end
  end
end
