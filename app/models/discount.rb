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
class Discount < ApplicationRecord
  has_one :order, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :deduction_in_percent, presence: true, numericality: { greater_than: 0 }
end
