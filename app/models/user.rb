class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :rememberable, :registerable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :trackable,
         :validatable,
         :lockable,
         :timeoutable

  has_one :user_profile
  after_create :create_user_profile

  attr_accessor :current_password #, :password_confirmation

  # def after_database_authentication
  #   self.update_attribute(:invite_code, nil)
  # end

  # Warden::Manager.after_set_user do |user,auth,opts|
  #   auth.cookies[:signed_in] = 1
  # end
  #
  # Warden::Manager.before_logout do |user,auth,opts|
  #   auth.cookies.delete :signed_in
  # end


  def update_password(params)
    if valid_password? params[:current_password]
      update params.without(:current_password)
    else
      assign_attributes params.without(:current_password)
      valid?
      errors.add :current_password, "is invalid"
      false
    end
  end

  def update_email(params)
    if valid_password?(params[:password])
      update(params.without(:password))
    else
      assign_attributes params.without(:current_password)
      valid?
      errors.add :password, "is invalid"
      false
    end
  end

  # def portal
  #   super || Environment.default_portal
  # end

  def email_required?
    !is_admin?
  end

  def is_admin?
    username == 'admin'
  end

  def active_for_authentication?
    super && !suspended_at
  end

end
