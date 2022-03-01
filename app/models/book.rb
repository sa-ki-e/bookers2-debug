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
  
  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     Book.where(title: content)
  #   elsif method == 'forward'
  #     Book.where('title LIKE ?', content+'%')
  #   elsif method == 'backward'
  #     Book.where('title LIKE ?', '%'+content)
  #   else
  #     Book.where('title LIKE ?', '%'+content+'%')
  #   end
  # end
end
