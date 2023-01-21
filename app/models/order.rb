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
  has_many :order_pizzas, dependent: :destroy
  has_many :pizzas, through: :order_pizzas
  has_many :order_promotions, dependent: :destroy
  has_many :promotions, through: :order_promotions
  belongs_to :discount, optional: true
end
