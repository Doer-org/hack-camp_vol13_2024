import subprocess
from flask import Flask, request, send_file
from PIL import Image
from PIL.PngImagePlugin import PngInfo

app = Flask(__name__)


@app.route("/")
def hello():
    return "Hello World!"


@app.route("/latex_to_image", methods=["POST"])
def latex_to_image():
    data = request.json
    latex_formula = data.get("formula")

    latex_source = f"""
    \\documentclass[12pt]{{article}}
    \\usepackage{{bm}}
    \\usepackage{{amsmath}}
    \\pagestyle{{empty}}
    \\begin{{document}}
    \\[ {latex_formula} \\]
    \\end{{document}}
    """

    with open("tmp/formula.tex", "w") as file:
        file.write(latex_source)

    # LaTeXファイルをPDFに変換
    subprocess.run(["pdflatex", "-output-directory", "tmp", "tmp/formula.tex"])

    # PDFをPNG画像に変換
    subprocess.run(
        [
            "convert",
            "-density",
            "300",
            "tmp/formula.pdf",
            "-trim",
            "+repage",
            "-background",
            "transparent",
            "tmp/formula.png",
        ]
    )

    # メタデータを付与
    image = Image.open("tmp/formula.png")
    meta = PngInfo()
    meta.add_text("formula", latex_formula)
    image.save("tmp/formula_with_meta.png", "PNG", pnginfo=meta)
    return send_file("tmp/formula_with_meta.png", mimetype="image/png")


if __name__ == "__main__":
    app.run(debug=False, host="0.0.0.0", port=5001)
