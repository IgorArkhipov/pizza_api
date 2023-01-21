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
require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
