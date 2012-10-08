class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def default_url
    "/assets/default/" + [version_name, "category_default.png"].compact.join('_')
  end

  process :resize_to_fit => [80, 80]

  version :thumb do
    process :resize_to_fill => [40,40]
  end

end