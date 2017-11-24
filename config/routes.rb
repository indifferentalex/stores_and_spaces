Rails.application.routes.draw do
  resources :stores do
    resources :spaces
  end
end
