class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true
  has_many :questions

  def generate_token!
    update_attribute :token, AppServices::AccessToken.generate(self)
  end

end
