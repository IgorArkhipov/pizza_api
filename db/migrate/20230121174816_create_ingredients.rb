# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :price, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
