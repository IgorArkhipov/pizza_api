# frozen_string_literal: true

# == Schema Information
#
# Table name: pizzas
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_pizzas_on_name  (name) UNIQUE
#
require 'test_helper'

class PizzaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
