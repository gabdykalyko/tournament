class TeamsController < ApplicationController
  before_action :set_teams, only: [:destroy_division_teams]
  before_action :set_team, only: [:update_scores]

  def index
    @division_a_teams = Team.where(division: 'A')
    @division_b_teams = Team.where(division: 'B')
  end

  def new
    @team = Team.new
  end

  def create
    assign_divisions

    redirect_to teams_path
  end

  def destroy_all_teams
    Team.destroy_all
    redirect_to teams_path
  end

  def update_scores
    if @team.update(team_params)
      redirect_to teams_path
    else
      render 'index'
    end
  end

  def generate_results
    teams = Team.where(division: params[:division]).order(score: :desc).limit(4)
    @result_teams = teams.shuffle.each_slice(2).to_a

    # Add logic to generate results or perform further actions based on the @result_teams

    render 'results'
  end

  private

  def set_teams
    @teams = Team.where(division: params[:division])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def assign_divisions
    all_teams = params[:team].values.shuffle
    division_a_teams = all_teams.slice(0, 8)
    division_b_teams = all_teams.slice(8, 16)

    Team.destroy_all

    division_a_teams.each do |team_name|
      Team.create(name: team_name, division: 'A')
    end

    division_b_teams.each do |team_name|
      Team.create(name: team_name, division: 'B')
    end
  end

  def team_params
    params.require(:team).permit(:score)
  end
end
