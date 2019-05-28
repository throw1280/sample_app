class Micropost < ApplicationRecord
  belongs_to :user
  scope :post_user, ->{order(created_at: :desc)}
  scope :where_user, ->(following_ids, id){where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:
    Settings.max_length_content}
  validate  :picture_size

  private

  def picture_size
    return unless picture.size > Settings.max_image_size.megabytes
    errors.add :picture, t("sizelimit")
  end
end
