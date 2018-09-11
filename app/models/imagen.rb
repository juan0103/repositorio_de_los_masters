class Imagen < ApplicationRecord
    mount_uploader :imagen_det, PictureUploader
    
    
end
