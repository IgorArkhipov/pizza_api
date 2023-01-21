# frozen_string_literal: true

# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  from       :integer
#  name       :string
#  to         :integer
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
  # test "the truth" do
  #   assert true
  # end
end
