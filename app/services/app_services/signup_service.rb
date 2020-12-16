# frozen_string_literal: true

module AppServices
  # Handles user signup
  module SignupService
    # @param [String] email
    # @param [String] first_name
    # @param [String] last_name
    # @param [String] password
    # @param [String] password_confirmation
    # @return AppServices::ServiceContract
    def self.register(email, first_name, last_name, password, password_confirmation)
      user = User.new(
        email: email,
        first_name: first_name,
        last_name: last_name,
        password: password,
        password_confirmation: password_confirmation
      )

      return AppServices::ServiceContract.error(user.errors) unless user.valid?

      user.save
      AppServices::ServiceContract.success(user)
    end
  end
end
