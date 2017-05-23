# Imports the Google Cloud client library
require "google/cloud/vision"

class Photo < ApplicationRecord

  has_many :faces, :dependent => :destroy

  # Scopes
  scope :filter_favorite, -> { where(favorite: true) }
  scope :filter_non, -> { eager_load(:faces) }
  scope :filter_description, -> { where.not(description: [nil, '']) }
  scope :filter_noface, -> { includes(:faces).where(faces: { id: nil }) }
  scope :filter_anger, -> { eager_load(:faces).merge(Face.anger) }
  scope :filter_blurred, -> { eager_load(:faces).merge(Face.blurred) }
  scope :filter_headwear, -> { eager_load(:faces).merge(Face.headwear) }
  scope :filter_joy, -> { eager_load(:faces).merge(Face.joy) }
  scope :filter_sorrow, -> { eager_load(:faces).merge(Face.sorrow) }
  scope :filter_surprise, -> { eager_load(:faces).merge(Face.surprise) }
  scope :filter_under_exposed, -> { eager_load(:faces).merge(Face.under_exposed) }

  scope :filter_day, -> day { where(created_at: day.to_time.all_day) }

  scope :order_order_num_asc, -> { reorder(order_num: :asc) }
  scope :order_lowest_charge_asc, -> { reorder(lowest_charge: :asc) }
  scope :order_lowest_charge_desc, -> { reorder(lowest_charge: :desc) }

  def self.sort(method)
    case method.to_s
      when 'lowest_charge_asc' then order_lowest_charge_asc
      when 'lowest_charge_desc' then order_lowest_charge_desc
      else
        order_order_num_asc
    end
  end

  def self.filter(method)
    return filter_favorite if method['favorite'] == 'true'
    return filter_description if method['description'] == 'true'
    return filter_noface if method['noface'] == 'true'
    return filter_anger if method['anger'] == 'true'
    return filter_blurred if method['blurred'] == 'true'
    return filter_headwear if method['headwear'] == 'true'
    return filter_joy if method['joy'] == 'true'
    return filter_sorrow if method['sorrow'] == 'true'
    return filter_surprise if method['surprise'] == 'true'
    return filter_under_exposed if method['under_exposed'] == 'true'

    return filter_day(method['day']) if method['day'].present?

    return filter_non if method.values.all? { |v| v == 'false' || v.nil? }
  end

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

    faces
  end

  def to_hash(str)
    str.scan(/(\w+):\s+(\d+)/).map{|k, v| [k.to_sym, v.to_i] }.to_h
  end

end
