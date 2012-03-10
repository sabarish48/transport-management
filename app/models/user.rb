class User < ActiveRecord::Base
  # Max & min lengths for all fields
  SCREEN_NAME_MIN_LENGTH = 4
  SCREEN_NAME_MAX_LENGTH = 20
  PASSWORD_MIN_LENGTH = 4
  PASSWORD_MAX_LENGTH = 40
  EMAIL_MAX_LENGTH = 50
  SCREEN_NAME_RANGE = SCREEN_NAME_MIN_LENGTH..SCREEN_NAME_MAX_LENGTH
  PASSWORD_RANGE = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

  # Text box sizes for display in the views
  SCREEN_NAME_SIZE = 20
  PASSWORD_SIZE = 20
  EMAIL_SIZE = 30

  validates_uniqueness_of :screen_name, :email
  validates_confirmation_of :password

  validates_length_of :screen_name, :within => SCREEN_NAME_RANGE
  validates_length_of :password, :within => PASSWORD_RANGE
  validates_length_of :email, :maximum => EMAIL_MAX_LENGTH
  validates_presence_of :email

  attr_accessor :current_password

  def validate
    errors.add(:email, "must be valid.") unless email.include?("@")
    if screen_name.include?(" ")
      errors.add(:screen_name, "cannot include spaces.")
    end
  end

  # Log a user in.
  def login!(session)
    session[:user_id] = self.id
  end

  # Log a user out.
  def self.logout!(session)
    session[:user_id] = nil
  end

  # Clear the password (typically to suppress its display in a view).
  def clear_password!
    self.password = nil
    self.password_confirmation = nil
    self.current_password = nil
  end

  # Return true if the password from params is correct.
  def correct_password?(params)
    current_password = params[:user][:current_password]
    password == current_password
  end

  # Generate messages for password errors.
  def password_errors(params)
    # Use User model's valid? method to generate error messages
    # for a password mismatch (if any).
    self.password = params[:user][:password]
    self.password_confirmation = params[:user][:password_confirmation]
    valid?
    # The current password is incorrect, so add an error message.
    errors.add(:current_password, "is incorrect")
  end

end
