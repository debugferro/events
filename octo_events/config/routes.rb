Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :events, only: [:create]
  get "/issues/:issue_number/events", to: "events#show"
end
