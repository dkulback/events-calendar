Rails.application.routes.draw do
  devise_for :users,
             controllers: { registrations: 'users/registraitions', sessions: 'users/sessions',
                            omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :shows

  root to: 'shows#index'
end
