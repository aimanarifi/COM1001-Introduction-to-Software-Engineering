# A post record from the database
class Post < Sequel::Model
    def get_tags
        # Split comma separated tags into an array
        # Removes spaces around the commas
        return tags.split(/\s*,\s*/)
    end

    def load(params)
        # Add parameters to current object
        # self.post_id = ?
        self.username = params.fetch("username", "").strip
        self.title = params.fetch("title", "").strip
        self.message = params.fetch("message", "").strip
        self.university = params.fetch("university", "").strip
        self.tags = params.fetch("tags", "").strip
        self.date_posted = Time.new.strftime("%Y-%m-%d %H:%M:%S").to_s
        self.is_moderated = 0 # Not moderated by default
        self.image_link = params.fetch("image_link", "").strip

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
        errors.add("username", "cannot be empty") if !username || username.empty?
        errors.add("title", "cannot be empty") if !title || title.empty?
        errors.add("message", "cannot be empty") if !message || message.empty?
        errors.add("university", "cannot be empty") if !university || university.empty?
        errors.add("tags", "cannot be empty") if !tags || tags.empty?
        errors.add("date_posted", "cannot be empty") if !date_posted || date_posted.empty?
        errors.add("is_moderated", "cannot be empty") if !is_moderated
        errors.add("is_image", "cannot be empty") if !is_image
    end
end
