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
        latex_source = <<~LATEX
          \\documentclass[12pt]{article}
          \\usepackage{bm}
          \\usepackage{amsmath}
          \\pagestyle{empty}
          \\begin{document}
          \\[ #{formula_params[:content]} \\]
          \\end{document}
        LATEX
      
        File.open("tmp/formula.tex", "w") { |file| file.write(latex_source) }
      
        # Convert LaTeX file to PDF
        system("pdflatex", "-output-directory=tmp", "./tmp/formula.tex")
      
        # Convert PDF to PNG image
        system("convert", "-density", "300", "./tmp/formula.pdf", "-trim", "+repage", "-background", "transparent", "./tmp/formula.png")
        @formula.image.attach(io: File.open("./tmp/formula.png"), filename: "formula.png", content_type: "image/png")
        @formula.save
      end
  end
  