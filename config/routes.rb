Siphon::Application.routes.draw do
  devise_for :users

  root to: "reformattings#index"

  resources :reformattings
  resources :microfilm_reels
  resources :microfilm_print_slips do
    member do
      get "record_targets"
    end
  end

  get :reformattings_print_slips, to: 'reformatting_print_slips#print'
end
