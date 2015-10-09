Rails.application.routes.draw do
  get   '/about',        :to => 'pages#about'
  get   '/terms_of_use', :to => 'pages#terms_of_use', :as => 'terms_of_use'
end
