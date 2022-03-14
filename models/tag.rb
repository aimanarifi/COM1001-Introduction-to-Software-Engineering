# A tag record from the database
class Tag < Sequel::Model
    def load(params)
        self.tag_name = params
    end

    def get_tag_name
        return self.tag_name
    end
end
