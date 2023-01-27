# frozen_string_literal: true

# == Schema Information
#
# Table name: pizzas
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pizzas_on_name  (name) UNIQUE
#
require 'test_helper'

class PizzaTest < ActiveSupport::TestCase
  test 'should create with valid attributes' do
    pizza = Pizza.new(name: 'Pepperoni', price: 10)
    assert pizza.save
  end

  test 'should not create with non-unique name' do
    Pizza.create(name: 'Pepperoni', price: 10)
    pizza = Pizza.new(name: 'Pepperoni', price: 15)
    assert_not pizza.save
    assert_not_nil pizza.errors[:name]
  end

  test 'should not create without name' do
    pizza = Pizza.new(price: 10)
    assert_not pizza.save
    assert_not_nil pizza.errors[:name]
  end

  test 'should not create without price' do
    pizza = Pizza.new(name: 'Pepperoni')
    assert_not pizza.save
    assert_not_nil pizza.errors[:price]
  end

  test 'should not create with negative price' do
    pizza = Pizza.new(name: 'Pepperoni', price: -10)
    assert_not pizza.save
    assert_not_nil pizza.errors[:price]
  end

  test 'should not create with non-numeric price' do
    pizza = Pizza.new(name: 'Pepperoni', price: 'ten')
    assert_not pizza.save
    assert_not_nil pizza.errors[:price]
  end

  test 'should destroy order_pizzas on destroy' do
    pizza = Pizza.create(name: 'Pepperoni', price: 10)
    order_pizza = OrderPizza.create(pizza:)
    pizza.destroy
    assert_raises(ActiveRecord::RecordNotFound) { order_pizza.reload }
  end
end
