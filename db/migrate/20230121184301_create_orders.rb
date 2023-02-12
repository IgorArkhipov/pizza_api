# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :string do |t|
      t.string :state, null: false
      t.belongs_to :discount, foreign_key: true

      t.timestamps
    end
  end
end
