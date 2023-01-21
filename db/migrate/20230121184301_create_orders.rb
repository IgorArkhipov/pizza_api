# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :state
      t.belongs_to :discount, foreign_key: true

      t.timestamps
    end
  end
end