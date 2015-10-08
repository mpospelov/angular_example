class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks

  def send_on_create_confirmation_instructions
    true
  end

  def confirmed?
    true
  end
end
