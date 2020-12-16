# frozen_string_literal: true

# Defines the JSON blueprint for the Question model
class QuestionBlueprint < Blueprinter::Base
  identifier :id
  fields :message, :user_id

  view :question_only do
    fields :message
  end

  view :full_question do
    fields :message, :user_id
  end
end