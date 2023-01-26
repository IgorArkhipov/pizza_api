# frozen_string_literal: true

class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.integer :from, null: false
      t.integer :to, null: false
      t.references :pizza, null: false, foreign_key: true
      t.references :size, null: false, foreign_key: true

      t.timestamps

      t.index :name, unique: true
    end
  end
end
