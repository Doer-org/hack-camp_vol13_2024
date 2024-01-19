class FormulaController < ApplicationController
    before_action :set_project
    before_action :set_formula, only: [:update, :destroy]

    # GET /projects/:project_id/formulars
    def index
      @formulars = @project.formulars
      render json: @formulars
    end

    # POST /projects/:project_id/formulars
    def create
      @formular = @project.formulars.new(formular_params)
  
      if @formular.save
        render json: @formular, status: :created, location: project_formular_url(@project, @formular)
      else
        render json: @formular.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /projects/:project_id/formulars/:id
    def update
      if @formular.update(formular_params)
        render json: @formular
      else
        render json: @formular.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /projects/:project_id/formulars/:id
    def destroy
      @formular.destroy
    end
  
    private
      def set_project
        @project = Project.find(params[:project_id])
      end
  
      def set_formula
        @formular = @project.formulars.find(params[:id])
      end
  
      def formular_params
        params.require(:formular).permit(:file_name, :content)
      end
  end
  