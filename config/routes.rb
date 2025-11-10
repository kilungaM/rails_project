Rails.application.routes.draw do
  # Root page
  root 'pages#home'

  # Static pages
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'  # optional, if you have a contact page

  # Meals routes
  resources :meals, only: [:index, :show] do
    collection do
      get 'search'  # /meals/search
    end
  end

  # Categories and ingredients
  resources :categories, only: [:index, :show]
  resources :ingredients, only: [:index, :show]

  # Users
  resources :users, only: [:index, :show, :new, :create, :edit, :update]

  # Authentication routes
  get 'signup', to: 'users#new', as: 'signup'    # signup form
  get 'login', to: 'sessions#new', as: 'login'   # login form
  post 'login', to: 'sessions#create'            # submit login
  delete 'logout', to: 'sessions#destroy', as: 'logout' # logout

  # Optional: admin namespace if you add an admin panel
  # namespace :admin do
  #   resources :meals
  #   resources :categories
  # end
end
