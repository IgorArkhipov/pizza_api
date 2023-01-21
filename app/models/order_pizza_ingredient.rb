# frozen_string_literal: true

# == Schema Information
#
# Table name: order_pizza_ingredients
#
#  id             :integer          not null, primary key
#  action_type    :string(7)        not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ingredient_id  :integer          not null
#  order_pizza_id :integer          not null
#
# Indexes
#
#  index_order_pizza_ingredients_on_ingredient_id   (ingredient_id)
#  index_order_pizza_ingredients_on_order_pizza_id  (order_pizza_id)
#
# Foreign Keys
#
#  ingredient_id   (ingredient_id => ingredients.id)
#  order_pizza_id  (order_pizza_id => order_pizzas.id)
#

class OrderPizzaIngredient < ApplicationRecord
  TYPES = %w[added removed].freeze

  belongs_to :order_pizza
  belongs_to :ingredient
end
