Rails.application.routes.draw do
  resources :articles
  resources :entries do
    collection do
      get :get_all_worklogs
      get :get_worklog_counts
      get :get_feedback_counts
      get :get_all_feedbacks
      get :get_type_specific_worklogs
      get :get_type_specific_feedbacks
    end
    member do
      get :get_entries_by_entry_type_id
    end
  end
  resources :entry_types do
    collection do
      get :get_custom_form
      get :get_version_list
      get :root_entry_types
      get :all_sub_entry_types
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
