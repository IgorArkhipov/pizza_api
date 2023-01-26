# frozen_string_literal: true

class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.string :name
      t.float :deduction_in_percent, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
