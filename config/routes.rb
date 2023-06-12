Rails.application.routes.draw do
  resources :teams, only: [:index, :new, :create]
  root 'teams#index'
  delete 'delete_all_teams', to: 'teams#destroy_all_teams', as: 'delete_all_teams'
  patch 'teams/:team_id/update_scores/:division', to: 'teams#update_scores', as: 'update_scores'
  post 'division_a_result', to: 'teams#division_a_result', as: 'division_a_result'
  post 'division_b_result', to: 'teams#division_b_result', as: 'division_b_result'
end
