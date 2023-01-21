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
class Pizza < ApplicationRecord
  has_many :order_pizzas, dependent: :destroy
end
