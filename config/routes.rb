Rails.application.routes.draw do
  resources :articles
  resources :entries
  resources :entry_types do
    collection do
      get :get_custom_form
      get :get_version_list
      get :root_entry_types
    end
    member do
      get :get_version_list
      get :get_custom_form
      get :sub_entry_types
    end
  end
  resources :tags do
    member do
      get :values
    end
    collection do
      get :get_billing_head_list
      get :get_open_suggestions
    end
  end
  resources :users do
    collection do
      get :get_users
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
