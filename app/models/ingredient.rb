# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ingredients_on_name  (name) UNIQUE
#
class Ingredient < ApplicationRecord
  has_many :order_pizza_ingredients, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
