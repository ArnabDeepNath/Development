from PIL import Image
import os

def crop_image(input_image_path, output_image_path, crop_size):
    original_image = Image.open(input_image_path)
    
    # Calculate the center coordinates for cropping
    width, height = original_image.size
    left = max((width - crop_size[0]) // 2, 0)
    top = max((height - crop_size[1]) // 2, 0)
    right = min(left + crop_size[0], width)
    bottom = min(top + crop_size[1], height)
    
    cropped_image = original_image.crop((left, top, right, bottom))
    cropped_image.save(output_image_path)

for i in range(1, 8):
    input_image_path = ""
    for ext in ['.png', '.jpg', '.jpeg']:
        if os.path.isfile(f"assets/{i}{ext}"):
            input_image_path = f"assets/{i}{ext}"
            break
    
    if input_image_path:
        input_extension = os.path.splitext(input_image_path)[1].lower()
        output_extension = '.jpg' if input_extension in ['.jpeg', '.jpg'] else '.png'
        output_image_path = f"outputs/output_{i}{output_extension}"  # Path to save the cropped image
        crop_size = (640, 640)
        
        crop_image(input_image_path, output_image_path, crop_size)
    else:
        print(f"File not found for {i}")
