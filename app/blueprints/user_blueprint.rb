# frozen_string_literal: true

# Defines the JSON blueprint for the User model
class UserBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :first_name, :last_name, :email
  end

  view :login do
    include_view :normal
    field :token
  end
end
