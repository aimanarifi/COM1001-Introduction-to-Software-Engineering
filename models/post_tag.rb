# Author: Alexander Johns
# A post tag record from the database
class PostTag < Sequel::Model
    def load(postID, tagID)
        self.postID = postID
        self.tagID = tagID
    end
end
