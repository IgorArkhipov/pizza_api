# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'yaml'

data = YAML.load_file('data/config.yml')

sizes = data['size_multipliers'].map do |name, multiplier|
  { name:, multiplier: }
end
Size.create!(sizes)

pizzas = data['pizzas'].map do |name, price|
  { name:, price: }
end
Pizza.create!(pizzas)

ingredients = data['ingredients'].map do |name, price|
  { name:, price: }
end
Ingredient.create!(ingredients)

promotions = data['promotions'].map do |name, promotion_data|
  pizza = Pizza.find_by(name: promotion_data['target'])
  size = Size.find_by(name: promotion_data['target_size'])
  { name:, pizza:, size:, from: promotion_data['from'], to: promotion_data['to'] }
end
Promotion.create!(promotions)

discounts = data['discounts'].map do |name, discount_data|
  { name:, deduction_in_percent: discount_data['deduction_in_percent'] }
end
Discount.create!(discounts)

orders_file = File.read('data/orders.json')
sample_orders = JSON.parse(orders_file)
sample_orders.each do |order_data|
  order = Order.create!(id: order_data['id'], state: order_data['state'], created_at: order_data['createdAt'])
  if order_data['discountCode']
    discount = Discount.find_by(name: order_data['discountCode'])
    order.update(discount:)
  end

  order_data['items'].each do |item|
    pizza = Pizza.find_by(name: item['name'])
    size = Size.find_by(name: item['size'])

    order_pizza = OrderPizza.create!(order:, pizza:, size:)

    item['add'].each do |ingredient_name|
      ingredient = Ingredient.find_by(name: ingredient_name)
      OrderPizzaIngredient.create!(order_pizza:, ingredient:, action_type: 'added')
    end

    item['remove'].each do |ingredient_name|
      ingredient = Ingredient.find_by(name: ingredient_name)
      OrderPizzaIngredient.create!(order_pizza:, ingredient:, action_type: 'removed')
    end
  end

  order_data['promotionCodes'].each do |promotion_code|
    promotion = Promotion.find_by(name: promotion_code)
    OrderPromotion.create!(order:, promotion:)
  end
end
