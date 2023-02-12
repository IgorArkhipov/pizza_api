# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ingredients_on_name  (name) UNIQUE
#
require 'test_helper'

class IngredientTest < ActiveSupport::TestCase
  test 'should create with valid attributes' do
    ingredient = Ingredient.new(name: 'Cheese', price: 2.5)
    assert ingredient.save
  end

  test 'should not create with non-unique name' do
    Ingredient.create(name: 'Cheese', price: 2.5)
    ingredient = Ingredient.new(name: 'Cheese', price: 3.0)
    assert_not ingredient.save
    assert_not_nil ingredient.errors[:name]
  end

  test 'should not create without name' do
    ingredient = Ingredient.new(price: 2.5)
    assert_not ingredient.save
    assert_not_nil ingredient.errors[:name]
  end

  test 'should not create without price' do
    ingredient = Ingredient.new(name: 'Cheese')
    assert_not ingredient.save
    assert_not_nil ingredient.errors[:price]
  end

  test 'should not create with negative price' do
    ingredient = Ingredient.new(name: 'Cheese', price: -2.5)
    assert_not ingredient.save
    assert_not_nil ingredient.errors[:price]
  end

  test 'should not create with non-numeric price' do
    ingredient = Ingredient.new(name: 'Cheese', price: 'two point five')
    assert_not ingredient.save
    assert_not_nil ingredient.errors[:price]
  end

  test 'should destroy order_pizza_ingredients on destroy' do
    ingredient = Ingredient.create(name: 'Cheese', price: 2.5)
    order_pizza_ingredient = OrderPizzaIngredient.create(action_type: 'added')
    order_pizza_ingredient.update(ingredient:)
    ingredient.destroy
    assert_raises(ActiveRecord::RecordNotFound) { order_pizza_ingredient.reload }
  end
end
