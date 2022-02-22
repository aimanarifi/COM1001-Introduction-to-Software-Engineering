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
end
