class User < ApplicationRecord
  def display_profile_photo
    if profile_photo.attached?
      profile_photo
    else
      '/teamlogo.png'
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.forgot_password(self).deliver# This sends an e-mail with a link for the user to reset the password
  end
  # This generates a random password reset token for the user
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


  has_one_attached :profile_photo, service: :local
  has_many :posts
  has_many :comments

  # adds virtual attributes for authentication
  # adds methods to set and authenticate against the bcrypt password
  # must use the naming convention xxx_digest where xxx is the attribute name of our desired password
  # https://edgeapi.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  has_secure_password
  # validates email

  has_many :likes
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :profile_photo, size: { less_than: 1.megabytes, message: 'Image must be less than 1MB' },
                            content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
