Rails.application.routes.draw do
  resources :articles
  resources :entries
  resources :entry_types do
    collection do
      get :get_custom_form
      get :get_version_list
    end
    member do
      get :get_version_list
      get :get_custom_form
    end
  end
  resources :tags do
    member do
      get :values
    end
    collection do
      get :get_project_list
    end
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
