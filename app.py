from flask import Flask, request, jsonify
from PIL import Image, ImageDraw
from flask_cors import CORS  # Flask CORSインポート
import os

app = Flask(__name__)

# CORSを全てのオリジンに対して有効にする
CORS(app)

UPLOAD_FOLDER = './uploads'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

def convert_to_pixel_art_with_grid(image_path, output_path, pixel_size=10, grid_color=(0, 0, 0)):
    image = Image.open(image_path)
    original_size = image.size

    image = image.resize(
        (original_size[0] // pixel_size, original_size[1] // pixel_size),
        Image.NEAREST
    )
    image = image.resize(original_size, Image.NEAREST)

    draw = ImageDraw.Draw(image)
    for x in range(0, original_size[0], pixel_size):
        draw.line((x, 0, x, original_size[1]), fill=grid_color)
    for y in range(0, original_size[1], pixel_size):
        draw.line((0, y, original_size[0], y), fill=grid_color)

    image.save(output_path)

@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files['file']
    
    # ファイル形式のチェック（PNG, JPG, JPEGのみ許可）
    if not file.filename.lower().endswith(('png', 'jpg', 'jpeg')):
        return jsonify({"error": "Invalid file format. Only PNG, JPG, JPEG are allowed."}), 400
    
    input_path = os.path.join(UPLOAD_FOLDER, file.filename)
    output_path = os.path.join(UPLOAD_FOLDER, 'converted_' + file.filename)

    file.save(input_path)
    convert_to_pixel_art_with_grid(input_path, output_path)
    
    return jsonify({"message": "File processed successfully", "output_path": output_path}), 200

if __name__ == '__main__':
    app.run(debug=True)
