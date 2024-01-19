Rails.application.routes.draw do
  resources :users, only: [:create, :show] do
    resources :projects, only: [:create, :update, :destroy, :index, :show]
  end

  resources :projects, only: [] do
    resources :formulas, only: [:create, :update, :destroy, :index]
  end
end
