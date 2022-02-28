# A user record from the database
class User < Sequel::Model
    
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