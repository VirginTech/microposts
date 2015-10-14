class Retweet < ActiveRecord::Base
  belongs_to :retweet, class_name: "Micropost"
  belongs_to :retweeted, class_name: "Micropost"
end
