# A user record from the database
class User < Sequel::Model
    def login(params)
        username = params.fetch("username", "").strip
        password = params.fetch("password", "").strip
      end
      
    def load(params)
        self.username = params.fetch("username", "").strip
        self.password = params.fetch("password", "").strip
    end
    
    def validate
     super
     errors.add("username", "cannot be empty") if username.empty?
     errors.add("password", "cannot be empty") if password.empty?
    end
    
    def exist?
     other_user = User.first(username: username)
     !other_user.nil? && other_user.password == password
    end

    def name
        # Return full name of user
        "#{first_name} #{last_name}"
    end

    def type_of_account
        # Return name of account type
        if account_type == 0
            "Reporter"
        elsif account_type == 1
            "Viewer"
        elsif account_type == 2
            "Moderator"
        elsif account_type == 3
            "Administrator"
        else
            # If a wrong number is somehow entered, return nothing
            ""
        end
    end
end