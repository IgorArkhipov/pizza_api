# frozen_string_literal: true

# == Schema Information
#
# Table name: order_pizzas
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :string           not null
#  pizza_id   :integer          not null
#  size_id    :integer          not null
#
# Indexes
#
#  index_order_pizzas_on_order_id  (order_id)
#  index_order_pizzas_on_pizza_id  (pizza_id)
#  index_order_pizzas_on_size_id   (size_id)
#
# Foreign Keys
#
#  order_id  (order_id => orders.id)
#  pizza_id  (pizza_id => pizzas.id)
#  size_id   (size_id => sizes.id)
#
class OrderPizza < ApplicationRecord
  belongs_to :order
  belongs_to :pizza
  belongs_to :size
  has_many :order_pizza_ingredients, dependent: :destroy
  has_many :ingredients, through: :order_pizza_ingredients
end
