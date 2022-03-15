# A university record from the database
class University < Sequel::Model
    def load(university_name)
        self.university_name = university_name
    end
end