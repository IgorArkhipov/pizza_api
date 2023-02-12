# frozen_string_literal: true

# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  from       :integer          not null
#  name       :string
#  to         :integer          not null
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
class Promotion < ApplicationRecord
  belongs_to :pizza
  belongs_to :size
  has_many :order_promotions, dependent: :destroy
  has_many :orders, through: :order_promotions

  validates :name, presence: true, uniqueness: true
  validates :from, :to, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
