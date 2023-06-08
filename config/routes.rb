Rails.application.routes.draw do
  resources :teams, only: [:index, :new, :create]
  root 'teams#index'
  delete 'delete_all_teams', to: 'teams#destroy_all_teams', as: 'delete_all_teams'
  patch 'teams/:team_id/update_scores/:division', to: 'teams#update_scores', as: 'update_scores'
  post 'teams/generate_results/:division', to: 'teams#generate_results', as: 'generate_results'
end
