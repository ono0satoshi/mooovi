class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  has_attached_file :avatar,
                      styles: {medium: "300x300#", thumb: "100x100#"}
  validates_attachment_content_type :avatar,
                                      content_type: ["image/jpg","image/ipeg","image/png"]

  has_many :reviews
end
