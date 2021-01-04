module Api
  module V1
    class PhotosController < ApplicationController
      def index
        photos = Photo.all
        
        render json: PhotoSerializer.new(photos, options).serialized_json
      end
      
      def show
        photo = Photo.find_by(id: params[:id])
        
        render json: PhotoSerializer.new(photo, options).as_json
      end
      
      private
      
      def options
        @options ||= { include: [:subjects, :scores] }
      end
    end
  end
end