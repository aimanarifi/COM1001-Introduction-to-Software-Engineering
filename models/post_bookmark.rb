# Author: Alexander Johns
# A post bookmark record from the database

class PostBookmark < Sequel::Model
    def load(params)
        self.postID = params.fetch("postID", "")
        self.userID = params.fetch("userID", "")
        self.date_bookmarked = Time.new.strftime("%Y-%m-%d %H:%M:%S").to_s
    end
end
