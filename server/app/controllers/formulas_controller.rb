require 'tempfile'
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
      tmp_img = get_img
      if tmp_img
        @formula.image.attach(io: tmp_img, filename: 'image.png', content_type: 'image/png')
      end
      if @formula.update(formula_params)
        image_url = rails_blob_url(@formula.image) if @formula.image.attached?
        render json: { formula: @formula, image_url: image_url }
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
          "formula": @formula.content.gsub('\\', '\\\\')
        }
        response = HTTParty.post(url, 
          body: body.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
        if response.success?
          temp_img = Tempfile.new(['image', '.png'])
          temp_img.binmode
          temp_img.write(response.body)
          temp_img.rewind
          temp_img
        else
          puts 'Failed to get image from API'
          nil
        end
      end
  end
  