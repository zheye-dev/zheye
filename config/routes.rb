Rails.application.routes.draw do
  resources :votes
  get 'search/index'

  resources :answers
  mount Ckeditor::Engine => '/ckeditor'
  get 'portal/index'

  resources :questions do
    resources :question_comments
    get 'question_votes', to: 'question_votes#index'
    post 'question_votes', to: 'question_votes#handle', as: :question_vote
    resources :answers do
      get 'answer_votes', to: 'answer_votes#index'
      post 'answer_votes', to: 'answer_votes#handle', as: :answer_vote
      resources :answer_comments
    end
  end

  resources :users do
    member do
      get 'all_questions'
      get 'all_answers'
      get 'all_comments'
      get 'all_downvotes'
      get 'all_upvotes'
    end
  end

  resources :user_sessions, only: [:create, :destroy]

  delete '/logout', to: 'user_sessions#destroy', as: :log_out
  get '/login', to: 'user_sessions#new', as: :log_in

  get '/me', to: 'users#cur_user'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'questions#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
