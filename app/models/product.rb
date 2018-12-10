class Product < ActiveRecord::Base
  has_many :reviews

  def review_average
    reviews.average(:rate).round #頭のselfは省略可能
  end
end
