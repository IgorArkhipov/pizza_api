# frozen_string_literal: true

Rails.application.routes.draw do
  get '/index', to: 'orders#index'
  patch '/update', to: 'orders#update'
end
