class FormulasController < ApplicationController
    before_action :set_project
    before_action :set_formula, only: [:update, :destroy]

    # GET projects/:project_id/formulas
    def index
      @formulas = @project.formulas
      render json: @formulas
    end

    # POST projects/:project_id/formulas
    def create
      @formula = @project.formulas.new(formula_params)
  
      if @formula.save
        render json: @formula, status: :created, location: project_formula_url(@project, @formula)
      else
        render json: @formula.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /projects/:project_id/formulas/:id
    def update
      # レンダリングして画像を追加する必要あり
      
      if @formula.update(formula_params)
        render json: @formula
      else
        render json: @formula.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /projects/:project_id/formulas/:id
    def destroy
      @formula.destroy
    end
  
    private
      def set_project
        @project = Project.find(params[:project_id])
      end
  
      def set_formula
        @formula = @project.formulas.find(params[:id])
      end
  
      def formula_params
        params.require(:formula).permit(:file_name, :content)
      end
  end
  