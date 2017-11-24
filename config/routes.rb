Rails.application.routes.draw do
  resources :stores do
    resources :spaces do
      get "price/:start_date/:end_date", on: :member, to: "spaces#price"
    end
  end
end
