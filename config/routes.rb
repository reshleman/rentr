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

  resources :listings, only: [:new, :create, :show] do
    resources :available_date_ranges, only: [:new, :create]
  end
end
