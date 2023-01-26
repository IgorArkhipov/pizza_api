# frozen_string_literal: true

class CreatePizzas < ActiveRecord::Migration[7.0]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.float :price, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
