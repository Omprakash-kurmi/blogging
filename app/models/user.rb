class User < ApplicationRecord
  devise :two_factor_authenticatable
  # devise :two_factor_authenticatable, :two_factor_backupable, otp_secret_encryption_key: ENV['OTP_SECRET_KEY']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes
  has_many :comments
end

