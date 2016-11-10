class Post < ActiveRecord::Base
	belongs_to :user
  has_many :likes
  has_many :liking_users, :through => :likes, :source => :user

	validates :caption, :user_id, :photo, presence: true
	mount_base64_uploader :photo, PhotoUploader

  def tags
    caption.scan(/\B#\w+/).map { |t| t[1..-1].downcase }
  end

  def as_json(options = {})
    super.as_json(options).merge({:tags => tags})
  end

  def like_count
    likes.count
  end
end
