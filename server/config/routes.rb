Rails.application.routes.draw do

  root to: proc { [200, {}, ['Hello World!']] }

  resources :users, only: [:create, :show] do
    resources :projects, only: [:create, :update, :destroy, :index, :show]
  end

  resources :projects, only: [:create, :update, :destroy, :index, :show] do
    resources :formulas, only: [:create, :update, :destroy, :index]
  end
end
