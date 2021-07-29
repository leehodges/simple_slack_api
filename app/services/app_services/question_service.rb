# frozen_string_literal: true
module AppServices
  # Handles slack question
  module QuestionService
    def self.new(message, user_id)
      @question = Question.new(
        message: message,
        user_id: user_id,
      )
      return AppServices::ServiceContract.error(@question.errors) unless @question.valid?
      
      poster = Slack::Poster.new(Rails.application.credentials[:slack_hook])
      message = @question.message
      message = message.gsub(/\\n/, "\n")
      body = { text: message }
      poster.send_message(body)
      if @question.save
        AppServices::ServiceContract.success(@question)
      else
        AppServices::ServiceContract.error(@question.errors)
      end
    end
  end
end