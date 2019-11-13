#  expected params
#
# file: Base64
# file_name: String
#

class PicturesController < ApplicationController
  def create
    @picture = Picture.new
    @picture.file.attach(io: image_io, filename: file_name)

    if @picture.save
      render json: @picture
    else
      render json: @picture.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /pictures/:id
  def destroy
    Picture.find(params[:id]).destroy
  end

  private

  def file_name
    params[:picture][:file_name]
  end

  def image_io
    decoded_image = Base64.decode64(params[:picture][:file])
    StringIO.new(decoded_image)
  end
end
