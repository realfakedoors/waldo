module Api
  module V1
    class TargetBoxesController < ApplicationController
      def show
        target_box = TargetBox.find_by(id: params[:id])
        
        render json: TargetBoxSerializer.new(target_box).as_json
      end
    end
  end
end