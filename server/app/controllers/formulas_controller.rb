require 'httparty'

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
  
    # PATCH /projects/:project_id/formulas/:id
    def update
      get_img
      image_url = rails_blob_url(@formula.image)
      updated_params = formula_params.merge(image_url: image_url)
      if @formula.update(updated_params)
        render json: { formula: @formula }
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

      def get_img
        if ENV['RAILS_ENV'] == 'development'
          url = Rails.application.credentials.tex_compile[:dev_url] + '/latex_to_image'
        else
          url = Rails.application.credentials.tex_compile[:prod_url] + '/latex_to_image'
        end
        body = {
          "formula": formula_params[:content].gsub('\\', '\\\\')
        }
        response = HTTParty.post(url, 
          body: body.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
        if response.success?
          image_data = StringIO.new(response.body)
          @formula.image.attach(io: image_data, filename: 'image.png', content_type: 'image/png')
          @formula.save
        else
          puts 'Failed to get image from API'
          # ここでエラーロギングを改善することを検討してください
        end
      end
  end
  