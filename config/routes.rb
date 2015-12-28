Rails.application.routes.draw do
  resources :lunch do
    collection do
      get :menu
      post :order
    end
  end
end
