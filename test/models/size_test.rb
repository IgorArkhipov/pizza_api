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
require 'test_helper'

class SizeTest < ActiveSupport::TestCase
  test 'should create with valid attributes' do
    size = Size.new(name: 'Small', multiplier: 0.5)
    assert size.save
  end

  test 'should not create with non-unique name' do
    Size.create(name: 'Small', multiplier: 0.5)
    size = Size.new(name: 'Small', multiplier: 0.7)
    assert_not size.save
    assert_not_nil size.errors[:name]
  end

  test 'should not create without name' do
    size = Size.new(multiplier: 1.0)
    assert_not size.save
    assert_not_nil size.errors[:name]
  end

  test 'should not create without multiplier' do
    size = Size.new(name: 'Small')
    assert_not size.save
    assert_not_nil size.errors[:multiplier]
  end

  test 'should not create with negative multiplier' do
    size = Size.new(name: 'Small', multiplier: -0.5)
    assert_not size.save
    assert_not_nil size.errors[:multiplier]
  end

  test 'should not create with non-numeric multiplier' do
    size = Size.new(name: 'Small', multiplier: 'negative')
    assert_not size.save
    assert_not_nil size.errors[:multiplier]
  end
end
