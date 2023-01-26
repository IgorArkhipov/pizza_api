# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    orders = Order.opened.includes(:discount, :promotions,
                                   order_pizzas: [:size, :pizza, { order_pizza_ingredients: :ingredient }])
    render 'orders/index', locals: { orders: }
  end

  def update
    order = Order.find(params[:id])
    if order.update(state: 'COMPLETE')
      redirect_to index_path
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end
end
