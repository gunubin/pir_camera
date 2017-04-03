require "open-uri"
require "rmagick"

# photos controller
class PhotosController < ApplicationController
  # GET /photos/
  def index

    query = {
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

    photo.get_face_api()

    render json: {status: "ok"}

  end

  def create


    file = params[:pic]
    # original_name = file.original_filename
    extname = '.png'
    name = Time.now.strftime('%H%M%S')


    @today = Time.now()

    path = "public/photos/#{@today.year}/#{@today.month}-#{@today.day}"

    FileUtils.mkdir_p(path) unless FileTest.exist?(path)
    # File.open("#{path}/#{name}#{extname}", 'wb') { |f|
    #   f.write(file.read)
    # }


    img = Magick::Image.from_blob(file.read).shift
    img.format = 'PNG'
    img.write("#{path}/#{name}.png")

    photo = Photo.create(filename: name + extname, path: path, extname: extname)
    photo.get_face_api()

    render json: {status: "ok"}

  end

end
