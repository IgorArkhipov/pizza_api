# frozen_string_literal: true

require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    size = Size.create!({ name: 'normal', multiplier: 1.0 })
    pizza = Pizza.create!({ name: 'cheap', price: 5.0 })
    @order = Order.create!(id: SecureRandom.uuid, state: 'OPEN')
    @complete_order = Order.create!(id: SecureRandom.uuid, state: 'COMPLETE')
    OrderPizza.create!(order_id: @order.id, pizza_id: pizza.id, size_id: size.id)
  end

  test 'should get index' do
    get index_path
    assert_response :success
    assert_template :index
    assert_select 'tr', count: 1
  end

  test 'should not retrieve orders with status not set to OPEN' do
    get index_path
    assert_template(
      'orders/index',
      locals: {
        orders: Order.opened
      }
    )
  end

  test 'should update order' do
    patch update_path(id: @order.id)
    assert_redirected_to index_path
    @order.reload
    assert_equal 'COMPLETE', @order.state
  end
end
