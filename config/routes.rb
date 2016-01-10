Rails.application.routes.draw do
  resources :lunch do
    collection do
      post :order
    end
  end
end
