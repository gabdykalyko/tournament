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
    @team = Team.find(params[:team_id])

    if @team.update(team_params)
      redirect_to teams_path
    else
      @division_a_teams = Team.where(division: 'A')
      @division_b_teams = Team.where(division: 'B')
      render 'index'
    end
  end

  def generate_results
    division = params[:division]

    if division == 'A'
      @division_a_teams = Team.where(division: 'A').order(score: :desc).limit(4)
      @highest_score_team = @division_a_teams.first
      @lowest_score_team = @division_a_teams.last
      @remaining_teams = @division_a_teams[1..2]
    elsif division == 'B'
      @division_b_teams = Team.where(division: 'B').order(score: :desc).limit(4)
      @highest_score_team = @division_b_teams.first
      @lowest_score_team = @division_b_teams.last
      @remaining_teams = @division_b_teams[1..2]
    end

    @division_a_teams = Team.where(division: 'A') # Добавьте эту строку
    @division_b_teams = Team.where(division: 'B') # и эту строку

    render 'index'
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
