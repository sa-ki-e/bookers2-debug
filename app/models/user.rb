class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  has_many :group_users, class_name: "Group_User", foreign_key: "user_id", dependent: :destroy
  #has_many :groups, through: group_users, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # #フォローした、されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # #一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def get_profile_image(x,y)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  profile_image.variant(resize_to_limit: [x,y]).processed
  end

  #|フォロー機能のメソッド| インスタンスメソッド
  #フォローしたときの処理
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  #フォローを外すときの処理
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  #フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  #search機能のメソッド
  def self.looks(searches,words)
    if searches == "forward_match"
      @users = User.where("name LIKE ?", "#{words}%")
    elsif searches == "backward_match"
      @users = User.where("name LIKE ?", "%#{words}")
    elsif searches == "perfect_match"
      @users = User.where("name LIKE ?", "#{words}")
    elsif searches == "partial_match"
      @users = User.where("name LIKE ?", "%#{words}%")
    end
  end

  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     User.where(name: content)
  #   elsif method == 'forward'
  #     User.where('name LIKE ?', content + '%')
  #   elsif method == 'backward'
  #     User.where('name LIKE ?', '%' + content)
  #   else
  #     User.where('name LIKE ?', '%' + content + '%')
  #   end
  # end


end
