get "/new-post" do
    redirect "/login" unless session[:logged_in]

    @post = Post.new
    erb :new_post
end

post "/new-post" do
    redirect "/login" unless session[:logged_in]

    # Create new post, add parameters from form
    @post = Post.new

    # Add session cookies to params hash
    params[:userID] = session[:userID]
    params[:universityID] = session[:universityID]
    params[:account_type] = session[:account_type]

    @post.load(params)

    if @post.valid?
        @post.save_changes

        @all_tags = Tag.all

        # Splits tags into an array
        @tags = params[:tags].split(/\s*,\s*/)

        @tags.each do |tag|
            tag.upcase!

            # If tag doesn't exist, create new tag
            tag_exists = false
            @all_tags.each do |does_tag_exist|
                if does_tag_exist[:tag_name] == tag
                    tag_exists = true
                    break
                end
            end

            if !tag_exists
                @tag = Tag.new
                @tag.load(tag)
                @tag.save_changes
            end

            # Add tag to post_tags table
            @post_tag = PostTag.new
            @post_tag.load(@post.get_post_id, 
                            DB[:tags].where(tag_name: tag)[:tagID][:tagID])
            @post_tag.save_changes
        end

        redirect "/"
    end

    erb :new_post
end
