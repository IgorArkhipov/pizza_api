# frozen_string_literal: true

# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_ingredients_on_name  (name) UNIQUE
#
class Ingredient < ApplicationRecord
  has_many :order_pizza_ingredients, dependent: :destroy
end
