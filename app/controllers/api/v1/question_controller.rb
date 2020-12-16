# frozen_string_literal: true

module Api
  module V1
    # Handles endpoints related to users
    class QuestionController < Api::V1::ApplicationController
      before_action :authenticate

      def ask
        @question = AppServices::QuestionService.new(params[:message], params[:user_id])

        render json: { success: false, errors: 'There was a problem posting the question to slack' }, status: 401 and return unless @question

        render json: { success: true, payload: QuestionBlueprint.render_as_hash(@question.payload), view: :question_only }, status: :ok
      end
    end
  end
end
