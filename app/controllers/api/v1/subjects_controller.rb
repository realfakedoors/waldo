module Api
  module V1
    class SubjectsController < ApplicationController
      def show
        subject = Subject.find_by(name: params[:name])
        
        render json: SubjectSerializer.new(subject, options).as_json
      end
      
      private
      
      def options
        @options ||= { include: %i[target_box] }
      end
    end
  end
end