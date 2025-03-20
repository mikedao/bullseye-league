class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }
  validate :password_complexity

  private

    def password_complexity
      return if password.blank?

      unless password.match(/[A-Z]/)
        errors.add(:password, "must include at least one uppercase letter")
      end

      unless password.match(/\d/)
        errors.add(:password, "must include at least one number")
      end
    end
end

