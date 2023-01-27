# frozen_string_literal: true

# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  from       :integer          not null
#  name       :string
#  to         :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pizza_id   :integer          not null
#  size_id    :integer          not null
#
# Indexes
#
#  index_promotions_on_name      (name) UNIQUE
#  index_promotions_on_pizza_id  (pizza_id)
#  index_promotions_on_size_id   (size_id)
#
# Foreign Keys
#
#  pizza_id  (pizza_id => pizzas.id)
#  size_id   (size_id => sizes.id)
#
require 'test_helper'

class PromotionTest < ActiveSupport::TestCase
  setup do
    @pizza = Pizza.create(name: 'Margherita', price: 10)
    @size = Size.create(name: 'Normal', multiplier: 1.0)
  end

  test 'should create with valid attributes' do
    promotion = Promotion.new(name: 'New Year', from: 2, to: 1,
                              pizza: @pizza, size: @size)
    assert promotion.save
  end

  test 'should not create with non-unique name' do
    Promotion.create(name: 'January', from: 2, to: 1,
                     pizza: @pizza, size: @size)
    promotion = Promotion.new(name: 'January', from: 2, to: 1,
                              pizza: @pizza, size: @size)
    assert_not promotion.save
    assert_not_nil promotion.errors[:name]
  end

  test 'should not create without name' do
    promotion = Promotion.new(from: 10, to: 20, pizza: @pizza, size: @size)
    assert_not promotion.save
    assert_not_nil promotion.errors[:name]
  end

  test 'should not create without from and to' do
    promotion = Promotion.new(name: 'New Year', pizza: @pizza, size: @size)
    assert_not promotion.save
    assert_not_nil promotion.errors[:from]
    assert_not_nil promotion.errors[:to]
  end

  test 'should not create with negative from and to' do
    promotion = Promotion.new(name: 'New Year', from: -2, to: -1,
                              pizza: @pizza, size: @size)
    assert_not promotion.save
    assert_not_nil promotion.errors[:from]
    assert_not_nil promotion.errors[:to]
  end

  test 'should not create with non-numeric from and to' do
    promotion = Promotion.new(name: 'New Year', from: 'two', to: 'one',
                              pizza: @pizza, size: @size)
    assert_not promotion.save
    assert_not_nil promotion.errors[:from]
    assert_not_nil promotion.errors[:to]
  end

  test 'should have related pizza' do
    promotion = Promotion.new(name: 'New Year', from: 2, to: 1, size: @size)
    assert_not promotion.save
    assert_not_nil promotion.errors[:pizza]
  end

  test 'should have related size' do
    promotion = Promotion.new(name: 'New Year', from: 2, to: 1,
                              pizza: @pizza)
    assert_not promotion.save
    assert_not_nil promotion.errors[:size]
  end
end
