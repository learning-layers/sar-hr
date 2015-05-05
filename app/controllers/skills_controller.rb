class SkillsController < ApplicationController
  def index
    render json: authorize(Skill.all), each_serializer: SkillStubSerializer
  end

  def show
    render json: authorize(Skill.find(params[:id]))
  end

  def create
    render json: authorize(Skill.create!(skill_params)), status: :created
  end

  def update
    skill = authorize(Skill.find(params[:id]))
    skill.update!(skill_params)
    render json: skill
  end

  def destroy
    authorize(Skill.find(params[:id])).delete
    head :no_content
  end

private

  def skill_params
    params.require(:skill).permit(:name)
  end
end
