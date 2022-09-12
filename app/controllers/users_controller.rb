class UsersController < ApplicationController

  def index
    matching_users = User.all
    @users = matching_users.order({:username => :asc})

    render({ :template => "user_templates/all_users.html.erb"})
  end
  
  def all_users
    matching_users = User.all
    @users = matching_users.order({:username => :asc})

    render({ :template => "user_templates/all_users.html.erb"})
  end

  def show
    username = params.fetch("username")
    matching_users = User.where({ :username => username })
    @user = matching_users.at(0)

    render({ :template => "user_templates/user_details.html.erb"})
  end
  
  def create
    user = User.new
    user.username = params.fetch("query_username")
    user.save
    
    redirect_to("/users/#{user.username}")
  end
  
  def update
    #Parameters: {"new_username" => "anisa"}
    url_username = params.fetch("new_username")
    matching_users = User.where({ :username => url_username })
    the_user = matching_users.at(0)
    
    new_username = params.fetch("query_username")
   
    the_user.username = new_username
    the_user.save

    redirect_to("/users/" + the_user.username)
  end

end
