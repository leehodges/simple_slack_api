# frozen_string_literal: true

module Api
  module V1
    # Handles endpoints related to users
    class UsersController < Api::V1::ApplicationController
      skip_before_action :authenticate, only: %i[login create accept_invitation]

      def create

        @current_user = AppServices::SignupService.register(params[:email], params[:first_name], params[:last_name],
                                                            params[:password], params[:password_confirmation])
        render json: { success: false, errors: 'There was a problem saving your user' }, status: 401 and return unless @current_user

        render json: { success: true, payload: UserBlueprint.render_as_hash(@current_user.payload, view: :normal) }, status: :ok
        puts @current_user
      end

      def login
        result = AppServices::AuthService.login(params[:email], params[:password])
        render json: { success: false, errors: 'User not authenticated' }, status: 401 and return unless result.success?

        render json: { success: true, payload: UserBlueprint.render_as_hash(result.payload, view: :login) }, status: :ok
      end

      def logout
        result = AppServices::AuthService.logout(@current_user)
        unless result.success?
          render json: { success: false, errors: 'There was a problem logging out' }, status: :unprocessable_entity and return
        end

        render json: { success: true, payload: 'You have been logged out' }, status: :ok
      end

      def me
        render json: UserBlueprint.render(@current_user), status: :ok
      end
    end
  end
end
