class Book < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  belongs_to :user
  validates :title,presence:true
  validates :body, presence:true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  #search機能のメソッド
  def self.looks(searches,words)
    if searches == "forward_match"
      @books = Book.where("title LIKE ?", "#{words}%")
    elsif searches == "backward_match"
      @books = Book.where("title LIKE ?", "%#{words}")
    elsif searches == "perfect_match"
      @books = Book.where("title LIKE ?", "#{words}")
    elsif searches == "partial_match"
      @books = Book.where("title LIKE ?", "%#{words}%")
    end
  end
  
end
