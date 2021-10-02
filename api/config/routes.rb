Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    use_doorkeeper
    resources :users, only: %i[create]
    resources :questions, only: %i[create]
    resources :answers, only: %i[create]

    get 'questions' => 'questions#get_questions'
    get 'questions/:id/answers' => 'questions#get_answers'

  end

end
