# frozen_string_literal: true

class CreateOrderPizzas < ActiveRecord::Migration[7.0]
  def change # rubocop:disable Metrics/MethodLength
    create_table :order_pizzas do |t|
      t.belongs_to :order, null: false, type: :uuid, foreign_key: true, index: true
      t.belongs_to :pizza, null: false, foreign_key: true, index: true
      t.belongs_to :size, null: false, foreign_key: true, index: true

      t.timestamps
    end
    create_table :order_pizza_ingredients do |t|
      t.belongs_to :order_pizza, null: false, foreign_key: true, index: true
      t.belongs_to :ingredient, null: false, foreign_key: true, index: true
      t.string :action_type, null: false, limit: 7

      t.timestamps
    end
  end
end
