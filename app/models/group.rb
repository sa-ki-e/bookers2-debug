class Group < ApplicationRecord
  has_many :group_users, class_name: "Group_User", foreign_key: "group_id", dependent: :destroy
  has_many :users, through: groupusers, dependent: :destroy
end
