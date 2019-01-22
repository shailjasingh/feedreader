Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :feeds do
    member do
      resources :entries, only: [:index, :show]
    end
  end

  root 'feeds#index'
end
