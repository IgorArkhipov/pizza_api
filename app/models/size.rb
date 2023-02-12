# frozen_string_literal: true

# == Schema Information
#
# Table name: sizes
#
#  id         :integer          not null, primary key
#  multiplier :float            not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_sizes_on_name  (name) UNIQUE
#
class Size < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :multiplier, presence: true, numericality: { greater_than: 0 }
end
