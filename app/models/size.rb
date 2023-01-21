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
class Size < ApplicationRecord
end
