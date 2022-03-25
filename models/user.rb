# Author: Lexi Wheadon & Alexander Johns
# Updated: Habil Bin Abdul Rahim Khan Suratee 
# A user record from the database
class User < Sequel::Model
    def load(params)
        self.username = params.fetch("username", "").strip
        self.password = params.fetch("password", "").strip
        self.email = params.fetch("email", "").strip
        self.first_name = params.fetch("first_name", "").strip
        self.last_name = params.fetch("last_name", "").strip
        self.is_suspended = params.fetch("is_suspended")
        self.account_type = params.fetch("account_type")
        self.universityID = params.fetch("universityID")
    end

    def login(params)
        self.username = params.fetch("username", "").strip
        self.password = params.fetch("password", "").strip
      end
      
    def validate
        super
        errors.add("username", "cannot be empty") if !username || username.empty?
        errors.add("password", "cannot be empty") if !password || password.empty?
    end

    def register_validate
        errors.add("username", "cannot be empty") if !username || username.empty?
        errors.add("username", "already exists") if User.where(username: username).count > 0
        errors.add("password", "cannot be empty") if !password || password.empty?
        errors.add("first_name", "cannot be empty") if !first_name || first_name.empty?
        errors.add("last_name", "cannot be empty") if !last_name || last_name.empty?
        errors.add("email", "cannot be empty") if !email || email.empty?
        errors.add("email", "cannot be an invalid format") if !(email =~ URI::MailTo::EMAIL_REGEXP)
        errors.add("email", "already exists") if User.where(email: email).count > 0

        if errors.length == 0
            return true
        else
            return false
        end
    end
    
    def exist?
        other_user = User.first(username: username) 
        another_user= User.first(email: username)
        (!other_user.nil? && other_user.password == password ) ||
         (!another_user.nil? && another_user.password == password )
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