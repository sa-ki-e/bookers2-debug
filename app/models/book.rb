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
  def self.looks(seaches,words)
    if searshes == "forward_match"
      @book = Book.where("title LIKE ?", "#{words}%")
    elsif searshes == "backward_match"
      @book = Book.where("title LIKE ?", "%#{words}")
    elsif searshes == "perfect_match"
      @@book = Book.where("title LIKE ?", "#{words}")
    elsif searshes == "partial_match"
      @book = Book.where("title LIKE ?", "%#{words}%")
    end
  end
end
