module Api
  module V1
    class PhotosController < ApplicationController
      protect_from_forgery with: :null_session
      skip_before_action :verify_authenticity_token
      
      def index
        photos = Photo.all
        
        render json: PhotoSerializer.new(photos, { include: [:subjects] }).serialized_json
      end
      
      def show
        photo = Photo.find_by(id: params[:id])
        
        render json: PhotoSerializer.new(photo, { include: [:subjects, :scores, :target_boxes] }).as_json
      end
    end
  end
end