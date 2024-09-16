Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/logout', to: 'sessions#destroy'

  root 'home#index'

  resources :calendars, only: [:index]

  # post 'google_calendar_webhook', to: 'webhooks#google_calendar'
  post 'google_calendar_webhook/:calendar_id', to: 'webhooks#google_calendar'

end
