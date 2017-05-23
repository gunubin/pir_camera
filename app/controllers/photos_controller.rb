require "open-uri"
require "rmagick"

# photos controller
class PhotosController < ApplicationController

  # GET /photos/
  def index
    query = {
      day: params[:day],
      favorite: params[:favorite],
      description: params[:description],
      noface: params[:noface],
      anger: params[:anger],
      blurred: params[:blurred],
      headwear: params[:headwear],
      joy: params[:joy],
      sorrow: params[:sorrow],
      surprise: params[:surprise],
      under_exposed: params[:under_exposed],
    }.with_indifferent_access

    @photos = Photo.filter(query).order('photos.id desc').limit(21).page(params[:page])

    render json: @photos.to_json(include: :faces)
  end

  # PUT /photos/#{id}
  def update
    @photo = Photo.find(params[:id])
    logger.info params.inspect
    @photo.update_attributes params[:params]
  end

  # GET /photos/favorite/:id
  def favorite
    if Photo.update(params[:id], {favorite: true}) then
      render json: {status: 'ok'}
    else
      render json: {status: 'ng'}
    end
  end

  # GET /photos/unfavorite/:id
  def unfavorite
    if Photo.update(params[:id], {favorite: false}) then
      render json: {status: 'ok'}
    else
      render json: {status: 'ng'}
    end
  end

  def create

    file = params[:pic]
    extname = '.png'
    name = Time.now.strftime('%H%M%S')

    @today = Time.now()

    path = "public/photos/#{@today.year}/#{@today.month}-#{@today.day}"

    FileUtils.mkdir_p(path) unless FileTest.exist?(path)

    img = Magick::Image.from_blob(file.read).shift
    img.format = 'PNG'
    img.write("#{path}/#{name}.png")

    photo = Photo.create(filename: name + extname, path: path, extname: extname)

    faces = photo.get_face_api

    tweet = tweetFaces(faces)

    render json: {status: "ok", tweet: tweet}

  end

  def apitest
    photo = Photo.find(params[:id])
    photo.get_face_api()
  end

  # POST /photos/upload
  # test用
  def upload

    # request.headers.sort.map { |k, v| logger.info "#{k}:#{v}" }
    # logger.info '========================================='
    # logger.info request.content_length
    # logger.info request.body.inspect

    my_read = request.body.read

    name = Time.now.strftime('%H%M%S')
    extname = '.png'

    @today = Time.now()

    path = "public/photos/#{@today.year}/#{@today.month}-#{@today.day}"

    FileUtils.mkdir_p(path) unless FileTest.exist?(path)
    # File.open("#{path}/#{name}#{extname}", 'wb') { |f|
    #   f.write(my_read)
    # }
    img = Magick::Image.from_blob(my_read).shift
    img.format = 'PNG'
    img.write("#{path}/#{name}#{extname}")

    photo = Photo.create(filename: name + extname, path: path, extname: extname)

    # unless Photo.is_uploadable(20.minutes) then
    #   render json: {status: "ok", message: "GoogleFaceAPIの時間内枚数制限です。"} and return
    # end

    faces = photo.get_face_api()

    tweet = tweetFaces(faces)

    render json: {status: "ok", tweet: tweet}

  end

  def tweetFaces(faces)
    tweet = ''
    if any?(faces) then
      tweet = feel_string(faces)
      faces.each do |face|
        likelihood = face.likelihood
        tweet << ' joy: ' + likelihood.joy.to_s if anyLevel(likelihood.joy.to_s)
        tweet << ' anger: ' + likelihood.anger.to_s if anyLevel(likelihood.anger.to_s)
        tweet << ' sorrow: ' + likelihood.sorrow.to_s if anyLevel(likelihood.sorrow.to_s)
        tweet << ' surprise: ' + likelihood.surprise.to_s if anyLevel(likelihood.surprise.to_s)
      end

      @twitter = twitter_client
      @twitter.update(tweet)
    end

    tweet
  end


  def feel_string(faces)
    result = 'おまめカメラが、'
    faces.each do |face|
      likelihood = face.likelihood
      result << "楽しいを検出しました " if anyLevel(likelihood.joy.to_s)
      result << "怒りを検出しました " if anyLevel(likelihood.anger.to_s)
      result << "悲しみを検出しました " if anyLevel(likelihood.sorrow.to_s)
      result << "驚きを検出しました " if anyLevel(likelihood.surprise.to_s)
    end
    result << ' '
  end

  # VERY_LIKELY	非常に高いレベル
  # LIKELY	高いレベル
  # POSSIBLE	そうだと言えるレベル
  # UNLIKELY	低いレベル
  # VERY_UNLIKELY	非常に低いレベル
  # UNKNOWN
  def anyLevel(feel)
    feel == 'VERY_LIKELY' || feel == 'LIKELY' || feel == 'POSSIBLE' || feel == 'UNLIKELY'
  end

  def anyFeels(face)
    feels = %w(joy anger sorrow surprise)
    feels.any? do |feel|
      anyLevel(face.likelihood.send(feel).to_s)
    end
  end

  def any?(faces)
    faces.any? do |face|
      anyFeels(face)
    end
  end

  def twitter_client

    @twitter = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']

      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

  end
  


  private
  
  def permitted_params
    params.permit!  #<=すべてのparamを許可するとき
  end

end
