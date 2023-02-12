# frozen_string_literal: true

class CreateOrderPromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :order_promotions do |t|
      t.belongs_to :order, null: false, type: :string, foreign_key: true, index: true
      t.belongs_to :promotion, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
