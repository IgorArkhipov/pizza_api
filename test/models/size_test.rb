# frozen_string_literal: true

# == Schema Information
#
# Table name: sizes
#
#  id         :integer          not null, primary key
#  multiplier :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sizes_on_name  (name) UNIQUE
#
require 'test_helper'

class SizeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
