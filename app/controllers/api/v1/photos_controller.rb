module Api
  module V1
    class PhotosController < ApplicationController
      def index
        photos = Photo.all
        
        render json: PhotoSerializer.new(photos, options).as_json
      end
      
      def show
        photo = Photo.find_by(name: params[:name].titleize)
        
        render json: PhotoSerializer.new(photo, options).as_json
      end
      
      private
      
      def options
        @options ||= { include: %i[subjects] }
      end
    end
  end
end