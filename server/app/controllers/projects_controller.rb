class ProjectsController < ApplicationController
  before_action :set_user
  before_action :set_project, only: [:show, :update, :destroy]

  # GET :user_id/projects
  def index
    @projects = Project.all
    render json: @projects
  end
  
  # GET :user_id/projects/:id
  def show
    render json: @project
  end
  
  # POST :user_id/projects
  def create
    @project = @user.projects.build(project_params)
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PUT :user_id/projects/:id
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE :user_id/projects/:id
  def destroy
    @project.destroy
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
  