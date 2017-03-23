# Imports the Google Cloud client library
require "google/cloud/vision"

class Photo < ApplicationRecord

  has_many :faces, :dependent => :destroy

  # after_save :get_face_api

  def self.is_uploadable(time)
    Photo.last.created_at < time.ago if Photo.last
  end

  def get_face_api

    # begin
    file_name = "#{self.path}/#{self.filename}"
    project_id = 'iot-pircamera'
    # 環境変数 GOOGLE_APPLICATION_CREDENTIALS=<path_to_service_account_file>
    vision = Google::Cloud::Vision.new project: project_id

      # Performs label detection on the image file
      faces = vision.image(file_name).faces

      faces.each do |face|
        likelihood = face.likelihood
        f = Face.new
        f.photo = self
        f.confidence = face.confidence
        f.bounds = face.bounds.to_h.to_json
        f.angles = face.angles.to_h.to_json
        f.features = face.features.to_h.to_json
        f.anger = likelihood.anger
        f.blurred = likelihood.blurred
        f.headwear = likelihood.headwear
        f.joy = likelihood.joy
        f.sorrow = likelihood.sorrow
        f.surprise = likelihood.surprise
        f.under_exposed = likelihood.under_exposed
        f.save()
      end
    # rescue
    # end

  end

  def to_hash(str)
    str.scan(/(\w+):\s+(\d+)/).map{|k, v| [k.to_sym, v.to_i] }.to_h
  end

end
