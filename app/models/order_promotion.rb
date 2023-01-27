# frozen_string_literal: true

# == Schema Information
#
# Table name: order_promotions
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  order_id     :string           not null
#  promotion_id :integer          not null
#
# Indexes
#
#  index_order_promotions_on_order_id      (order_id)
#  index_order_promotions_on_promotion_id  (promotion_id)
#
# Foreign Keys
#
#  order_id      (order_id => orders.id)
#  promotion_id  (promotion_id => promotions.id)
#
class OrderPromotion < ApplicationRecord
  belongs_to :order
  belongs_to :promotion
end
