class Micropost < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size
  scope :order_desc, ->{order created_at: :desc}
  scope :feed_items, ->following_ids, id{where "user_id IN (?) OR user_id = ?", following_ids, id}

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, t("micropost.picturelessthan")
    end
  end
end
