# frozen_string_literal: true

# == Schema Information
#
# Table name: discounts
#
#  id                   :integer          not null, primary key
#  deduction_in_percent :float
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
  # test "the truth" do
  #   assert true
  # end
end
