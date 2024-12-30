from PIL import Image, ImageDraw

def convert_to_pixel_art_with_grid(input_image_path, output_image_path, pixel_size=10, grid_color=(0, 0, 0)):
    # 画像を開く
    image = Image.open(input_image_path)

    # 元の画像のサイズを取得
    original_size = image.size

    # 指定されたピクセルサイズに合わせて縮小する
    image = image.resize(
        (original_size[0] // pixel_size, original_size[1] // pixel_size),
        Image.NEAREST
    )

    # 元のサイズに戻す
    image = image.resize(original_size, Image.NEAREST)

    # グリッド線を描画するためのDrawオブジェクトを作成
    draw = ImageDraw.Draw(image)

    # 縦のグリッド線を描画
    for x in range(0, original_size[0], pixel_size):
        draw.line((x, 0, x, original_size[1]), fill=grid_color)

    # 横のグリッド線を描画
    for y in range(0, original_size[1], pixel_size):
        draw.line((0, y, original_size[0], y), fill=grid_color)

    # 結果を保存する
    image.save(output_image_path)

# 入力画像のパスと出力画像のパスを設定
input_path = 'input_image.png'
output_path = 'output_pixel_art_with_grid.png'

# ドット絵に変換し、グリッド線を追加する
convert_to_pixel_art_with_grid(input_path, output_path, pixel_size=10, grid_color=(0, 0, 0))
