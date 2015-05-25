class SkillsController < ApplicationController
  def index
    render json: policy_scope(Skill), each_serializer: SkillStubSerializer
  end

  def show
    skill = Skill.find(params[:id])

    authorize(skill)

    render json: skill
  end

  def create
    skill = Skill.create!(skill_params)

    authorize(skill)

    render json: skill, status: :created
  end

  def update
    skill = Skill.find(params[:id])

    authorize(skill)

    skill.update!(skill_params)

    render json: skill
  end

  def destroy
    skill = Skill.find(params[:id])

    authorize(skill)

    skill.destroy!

    head :no_content
  end

private

  def skill_params
    params.require(:skill).permit(:name)
  end
end
