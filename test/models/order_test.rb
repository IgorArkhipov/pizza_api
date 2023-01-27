# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id          :string           not null, primary key
#  state       :string           not null
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
require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test 'should create with valid attributes' do
    order = Order.new(state: 'OPEN')
    discount = Discount.create(name: 'January', deduction_in_percent: 10)
    order.update(discount:)
    assert_equal discount, order.discount
  end

  test 'should not create without state' do
    order = Order.new
    assert_not order.save
    assert_not_nil order.errors[:state]
  end

  test "should not create with state other than 'OPEN' or 'COMPLETE'" do
    order = Order.new(state: 'IN_PROGRESS')
    assert_not order.save
    assert_not_nil order.errors[:state]
  end

  test "opened scope only returns orders with state 'OPEN'" do
    order1 = Order.create(state: 'OPEN')
    Order.create(state: 'COMPLETE')
    order3 = Order.create(state: 'OPEN')
    assert_equal [order1, order3], Order.opened.to_a
  end

  test 'total_price with discount' do
    discount = Discount.create(name: 'Winter20', deduction_in_percent: 20)
    pizza = Pizza.create(name: 'Margherita', price: 10)
    size = Size.create(name: 'Normal', multiplier: 1)
    order = Order.create(state: 'OPEN', discount:)
    OrderPizza.create(pizza:, size:, order:)

    assert_equal 8.0, order.total_price
  end

  test 'total_price without discount' do
    pizza = Pizza.create(name: 'Margherita', price: 10)
    size = Size.create(name: 'Normal', multiplier: 1)
    order = Order.create(state: 'OPEN')
    OrderPizza.create(pizza:, size:, order:)

    assert_equal 10.0, order.total_price
  end

  test 'pizzas_aggregated_price' do
    pizza = Pizza.create(name: 'Margherita', price: 10)
    size = Size.create(name: 'Large', multiplier: 1.2)
    promotion = Promotion.create(name: 'Promotion', pizza:, size:, from: 2, to: 1)
    order = Order.new(state: 'OPEN')
    2.times { |_| OrderPizza.create(pizza:, size:, order:) }
    OrderPromotion.create(order:, promotion:)

    result = order.send(:pizzas_aggregated_price,
                        order.order_pizzas.group_by { |p| [p.pizza, p.size] },
                        order.promotions)

    assert_equal 12.0, result
  end

  test 'ingredients_price should only sum up added ingredients' do
    order = Order.create(state: 'OPEN')
    pizza = Pizza.create(name: 'Margherita', price: 10)
    size = Size.create(name: 'Large', multiplier: 1.2)
    order_pizza = OrderPizza.create(pizza:, size:, order:)
    added_ingredient = Ingredient.create(name: 'Cheese', price: 2.0)
    removed_ingredient = Ingredient.create(name: 'Onions', price: 1.0)
    order.order_pizzas.first.order_pizza_ingredients.create(ingredient: added_ingredient, action_type: 'added')
    order.order_pizzas.first.order_pizza_ingredients.create(ingredient: removed_ingredient, action_type: 'removed')

    assert_equal added_ingredient.price, order.send(:ingredients_price, [order_pizza])
  end
end
