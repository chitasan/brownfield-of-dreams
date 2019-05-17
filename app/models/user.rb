# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def show_bookmarked_tutorials
    display_tutorials = Hash.new { |hash, key| hash[key] = [] }
    bookmarked_tutorials.each do |bookmark|
      key = { bookmark.tutorial_id => bookmark.tutorial_title }
      value = { bookmark.id => bookmark.title }
      display_tutorials[key] << value
    end
    display_tutorials
  end

  private

  def bookmarked_tutorials
    user_videos.joins(video: :tutorial)
      .select('tutorials.title as tutorial_title, tutorials.id as tutorial_id, videos.id, videos.title')
      .order('tutorials.id, videos.position')
  end
end
