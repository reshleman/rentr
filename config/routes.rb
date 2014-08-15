require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do
  constraints Monban::Constraints::SignedIn.new do
    root "listings#new"
  end

  constraints Monban::Constraints::SignedOut.new do
    root "sessions#new", as: :landing
  end

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  get "search" => "search_results#show"

  resources :listings, only: [:new, :create, :show] do
    resources :availabilities, only: [:new, :create]
    resources :photos, only: [:new, :create]
    resources :reservations, only: [:new, :create]
  end

  resources :reservations, only: [:show, :index] do
    resources :orders, only: [:create]
  end
end
