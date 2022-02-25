class Relationship < ApplicationRecord
  
  belongs_to :follower, class_name: "User" #フォローするユーザー
  belongs_to :followed, class_name: "User" #フォローされるユーザー
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  validates :follower_id, uniqueness: { scope: :followed_id }
#参考記事　https://tech-essentials.work/course_outputs/165
# この記述でfollower_idとfollowed_idの組をuniqueにした。１通りのみ許可のバリデーション。
# uniquenessはRails Validationヘルパーの一つで属性の値が一意（unique）であり重複していないことを検証する。
# （属性について同じ値のレコードがモデルにあるかをクエリを走らせ確認する）
# scopeオプションは他のカラムに一意性制約を求めることが出来る。
# 今回のケースだと、ひとつの":follower_id"シンボルに紐づくscope先の"followed_id"カラムのレコードに対しuniquenessを実行している。

end
