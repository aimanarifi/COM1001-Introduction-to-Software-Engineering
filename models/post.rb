# A post record from the database
class Post < Sequel::Model
    def get_tags
        # Split comma separated tags into an array
        # Removes spaces around the commas
        return tags.split(/\s*,\s*/)
    end

    def load(params)
        self.username = params.fetch("username", "") # TODO - might need to be changed to user ID
        self.university = params.fetch("university", "").strip # TODO - automatically get uni from the user account
        self.title = params.fetch("title", "").strip
        self.message = params.fetch("message", "").strip
        self.tags = params.fetch("tags", "").strip
        self.image_link = params.fetch("image_link", "").strip
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
    end

    def validate
        # Check if a new post object is valid
        super
        errors.add("title", "cannot be empty") if !title || title.empty?
        errors.add("title", "cannot be more than 100 characters") if title.length>100
        errors.add("message", "cannot be empty") if !message || message.empty?
        errors.add("message", "cannot be more than 1000 characters") if message.length>1000
        errors.add("university", "cannot be empty") if !university || university.empty?
        errors.add("tags", "cannot be empty") if !tags || tags.empty?
        # TODO - check if image link is valid
    end
end
