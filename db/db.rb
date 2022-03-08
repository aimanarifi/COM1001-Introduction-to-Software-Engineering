# Sets up the sqlite3 database file

# Gems
require "logger"
require "sequel"

# Create required users if they don't exist
def create_users
    DB[:users].insert(username: "admin", password: "admin", email:"admin@admin.com",
                first_name: "Admin", last_name: "Admin", is_suspended: 0, 
                account_type: 3, universityID: 239)
    DB[:users].insert(username: "reporter1", password: "reporter1", email:"reporter1@reporter.com",
                first_name: "Reporter", last_name: "Reporter", is_suspended: 0, 
                account_type: 0, universityID: 239)
    DB[:users].insert(username: "reporter2", password: "reporter2", email:"reporter2@reporter.com",
                first_name: "Reporter", last_name: "Reporter", is_suspended: 0, 
                account_type: 0, universityID: 239)
    DB[:users].insert(username: "moderator", password: "moderator", email:"moderator@moderator.com",
                first_name: "Moderator", last_name: "Moderator", is_suspended: 0, 
                account_type: 2, universityID: 239)
    DB[:users].insert(username: "viewer1", password: "viewer1", email:"viewer1@viewer.com",
                first_name: "Viewer", last_name: "Viewer", is_suspended: 0, 
                account_type: 1, universityID: 239)
    DB[:users].insert(username: "viewer2", password: "viewer2", email:"viewer2@viewer.com",
                first_name: "Viewer", last_name: "Viewer", is_suspended: 0, 
                account_type: 1, universityID: 239)
end

# Create university records if they don't exist
def create_universities
    File.open("db/universities.txt") do |university_list|
        university_list.each do |university|
            DB[:universities].insert(university_name: university.chomp)
        end
    end
end

# Create tables if they don't exist
def create_tables
    unless DB.table_exists?(:tags)
        DB.create_table :tags do
            primary_key :tagID
            column :tag_name, String
        end
    end

    unless DB.table_exists?(:universities)
        DB.create_table :universities do
            primary_key :universityID
            column :university_name, String
        end

        create_universities
    end

    unless DB.table_exists?(:users)
        DB.create_table :users do
            primary_key :userID
            column :username, String
            column :password, String
            column :email, String
            column :first_name, String
            column :last_name, String
            column :is_suspended, Integer
            column :account_type, Integer
            foreign_key :universityID, :universities
        end

        create_users
    end

    unless DB.table_exists?(:posts)
        DB.create_table :posts do
            primary_key :postID
            foreign_key :userID, :users
            column :title, String
            column :message, String
            column :date_posted, String
            column :is_moderated, Integer
            column :is_image, Integer
            column :image_link, String
            foreign_key :universityID, :universities
        end
    end

    unless DB.table_exists?(:post_tags)
        DB.create_table :post_tags do
            primary_key [:postID, :tagID]
            foreign_key :postID, :posts
            foreign_key :tagID, :tags
        end
    end

    unless DB.table_exists?(:deleted_users)
        DB.create_table :deleted_users do
            primary_key :deleteID_user # this need tweaking on here and deleted posts
            foreign_key :userID, :users
            column :date_deleted, String # this needs tweaking on here and deleted posts
        end
    end

    unless DB.table_exists?(:deleted_posts)
        DB.create_table :deleted_posts do
            primary_key :deleteID_post
            foreign_key :userID, :users
            column :date_deleted, String
        end
    end

    unless DB.table_exists?(:reported_posts) # whole thing needs tweaking
        DB.create_table :reported_posts do
            primary_key :reported_postID #tweak this later
            foreign_key :postID, :posts
            foreign_key :report_reasonID, :report_reasons 
            column :report_count, Integer
        end
    end

    unless DB.table_exists?(:report_reasons)
        DB.create_table :report_reasons do
            primary_key :report_reasonID
            column :report_name, String
        end
    end
end

unless defined?(DB)
    # What mode are we in?
    type = ENV.fetch("APP_ENV", "production")

    # Find the path to the database file
    db_path = File.dirname(__FILE__)
    db = "#{db_path}/#{type}.sqlite3"

    # Find the path to the logger
    log_path = "#{File.dirname(__FILE__)}/../log/"
    log = "#{log_path}/#{type}.log"

    # Create log directory if it doesn't exist
    Dir.mkdir(log_path) unless File.exist?(log_path)

    # Set up the Sequel databse instance
    DB = Sequel.sqlite(db, logger: Logger.new(log))

    create_tables
end