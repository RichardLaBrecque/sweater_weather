class User < ApplicationRecord
  before_validation :normalize_email, on: :create

  validates_presence_of :email
  validates_uniqueness_of :email
  has_secure_password
  has_secure_token :api_key
private

  def normalize_email
    if self.email
      self.email = self.email.downcase
    end

  end



end
