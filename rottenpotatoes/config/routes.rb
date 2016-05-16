Rottenpotatoes::Application.routes.draw do
  #get '/movies/:id/same_director', :to => 'movies#same_director'
  resources :movies do
    member do
      get 'same_director'
    end
  end
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end