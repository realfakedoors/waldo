module Api
  module V1
    class ScoresController < ApplicationController
      protect_from_forgery with: :null_session
      skip_before_action :verify_authenticity_token
      
      def index
        scores = Score.all.order('time::integer ASC').limit(10)
        
        render json: ScoreSerializer.new(scores).as_json
      end
      
      def create
        score = Score.new(score_params)
        
        if score.save
          render json: ScoreSerializer.new(score).as_json
        else
          render json: { error: score.errors.messages }, status: 422
        end
      end
      
      def destroy
        score = Score.find_by(id: params[:id])
        
        if score.destroy
          head :no_content
        else
          render json: { error: score.errors.messages }, status: 422
        end
      end
      
      private
      
      def score_params
        params.require(:score).permit(:time, :initials)
      end
    end
  end
end