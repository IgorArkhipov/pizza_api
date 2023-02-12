# frozen_string_literal: true

# == Schema Information
#
# Table name: discounts
#
#  id                   :integer          not null, primary key
#  deduction_in_percent :float            not null
#  name                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_discounts_on_name  (name) UNIQUE
#
require 'test_helper'

class DiscountTest < ActiveSupport::TestCase
  test 'should create with valid attributes' do
    discount = Discount.new(name: 'Sale', deduction_in_percent: 10)
    assert discount.save
  end

  test 'should not create with non-unique name' do
    Discount.create(name: 'Sale', deduction_in_percent: 10)
    discount = Discount.new(name: 'Sale', deduction_in_percent: 20)
    assert_not discount.save
    assert_not_nil discount.errors[:name]
  end

  test 'should not create without name' do
    discount = Discount.new(deduction_in_percent: 10)
    assert_not discount.save
    assert_not_nil discount.errors[:name]
  end

  test 'should not create without deduction_in_percent' do
    discount = Discount.new(name: 'Sale')
    assert_not discount.save
    assert_not_nil discount.errors[:deduction_in_percent]
  end

  test 'should not create with negative deduction_in_percent' do
    discount = Discount.new(name: 'Sale', deduction_in_percent: -10)
    assert_not discount.save
    assert_not_nil discount.errors[:deduction_in_percent]
  end

  test 'should not create with non-numeric deduction_in_percent' do
    discount = Discount.new(name: 'Sale', deduction_in_percent: 'ten')
    assert_not discount.save
    assert_not_nil discount.errors[:deduction_in_percent]
  end

  test 'should nullify order on destroy' do
    order = Order.create(id: SecureRandom.uuid, state: 'OPEN')
    discount = Discount.create(name: 'Sale', deduction_in_percent: 10)
    order.update(discount:)
    discount.destroy
    assert_nil order.reload.discount_id
  end
end
