# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [280, 280]
  end

  version :carousel do
    process resize_to_fit: [2000, 300]
  end

  version :public do
    process resize_to_fit: [1000, 1000]
  end

  def extension_white_list
     %w(jpg jpeg)
  end

  def filename
    if original_filename
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end
end
