# A post record from the database
class Post < Sequel::Model
    def load(params)
        self.userID = params.fetch("userID", "") 
        self.title = params.fetch("title", "").strip
        self.message = params.fetch("message", "").strip
        self.date_posted = Time.new.strftime("%Y-%m-%d %H:%M:%S").to_s

        # If user is moderator or admin, post doesn't need to be moderated
        if params.fetch("account_type").to_i == 2 || params.fetch("account_type").to_i == 3
            self.is_moderated = 1
        else
            self.is_moderated = 0 
        end

        # If image link is empty, post doesn't have an image
        if self.image_link == ""
            self.is_image = 0
        else
            self.is_image = 1
        end

        self.image_link = params.fetch("image_link", "").strip
        self.universityID = params.fetch("universityID", "")
    end

    def validate
        # Check if a new post object is valid
        super
        errors.add("title", "cannot be empty") if !title || title.empty?
        errors.add("title", "cannot be more than 100 characters") if title.length>100
        errors.add("message", "cannot be empty") if !message || message.empty?
        errors.add("message", "cannot be more than 1000 characters") if message.length>1000
        # TODO - check if image link is valid
    end

    def get_post_id
        return self.postID
    end
    
    def publish(params)
        #save change the modifiable data
        self.title = params.fetch("title").strip
        self.message = params.fetch("message").strip
        self.is_moderated = 1

        #if the post has image, check whether it want to be deleted or not
        if self.is_image == 1
            self.image_link = params.fetch("image_link").strip
            self.is_image = 0 if self.image_link == ""
        end

    end
end
