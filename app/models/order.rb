# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id          :uuid             not null, primary key
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  discount_id :integer
#
# Indexes
#
#  index_orders_on_discount_id  (discount_id)
#
# Foreign Keys
#
#  discount_id  (discount_id => discounts.id)
#
class Order < ApplicationRecord
  VALID_STATES = %w[OPEN COMPLETE].freeze

  belongs_to :discount, optional: true
  has_many :order_pizzas, dependent: :destroy
  has_many :pizzas, through: :order_pizzas
  has_many :order_promotions, dependent: :destroy
  has_many :promotions, through: :order_promotions

  scope :opened, -> { where(state: 'OPEN') }

  validates :state, presence: true, inclusion: { in: VALID_STATES }

  def total_price
    if discount
      (pizzas_with_extras_price * (1 - (discount.deduction_in_percent / 100.0))).round(2)
    else
      pizzas_with_extras_price
    end
  end

  private

  def pizzas_with_extras_price
    order_pizzas_groups = order_pizzas.group_by { |p| [p.pizza, p.size] }

    pizzas_aggregated_price(order_pizzas_groups, promotions)
  end

  def pizzas_aggregated_price(order_pizzas_groups, promotions)
    order_pizzas_price = 0.0
    order_pizzas_groups.each do |key, group|
      pizza, size = key

      promotion = promotions.find { |p| p.pizza == pizza && p.size == size }
      count = promotion ? group.count - ((group.count / promotion.from) * promotion.to) : group.count
      price = (size.multiplier * ((pizza.price * count) + ingredients_price(group)))
      order_pizzas_price += price
    end
    order_pizzas_price.round(2)
  end

  def ingredients_price(group)
    group.flat_map(&:order_pizza_ingredients)
         .select { |x| x.action_type == 'added' }
         .map(&:ingredient)
         .map(&:price)
         .sum
  end
end
