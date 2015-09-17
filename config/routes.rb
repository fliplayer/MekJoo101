Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, path_names: {
  		sign_up: ''
	}
  resources :posts do
  	resources :comments
  end

  root "posts#index"

  get '/about', to: 'pages#about'

end
