# frozen_string_literal: true

class CreateSizes < ActiveRecord::Migration[7.0]
  def change
    create_table :sizes do |t|
      t.string :name
      t.float :multiplier, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
