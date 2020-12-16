# frozen_string_literal: true

module AppServices
  # Handles user authentication (login, logout)
  module AuthService
    def self.login(email, password)
      # will return nil if no user found, will return false if the try authenticate doesn't work
      user = User.find_by(email: email).try(:authenticate, password)

      # If we couldn't find the user
      return AppServices::ServiceContract.error('User not found') if user.nil?

      # If the password wasn't correct
      return AppServices::ServiceContract.error('Incorrect password') unless user

      # generate the token on the user obj
      user.generate_token!
      AppServices::ServiceContract.success(user)
    end

    def self.logout(user)
      return AppServices::ServiceContract.success(nil) if user.update(token: nil)

      AppServices::ServiceContract.error('Error logging user out')
    end

  end
end
