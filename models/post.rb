# A post record from the database
class Post < Sequel::Model
    def get_tags
        # Split comma separated tags into an array
        # Removes spaces around the commas
        tags.split(/\s*,\s*/)
    end
end