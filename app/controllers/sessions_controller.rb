class SessionsController < ApplicationController
  def new
  end

  def create
    # Pulls the user out of the database
    # Email addresses are all saved in the db as lowerase, so use downcase here
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in
      log_in user
      # Redirect to the user's show page; below is same as user_url(user)
      redirect_to user
    else
      # Create an error message using flash.now (flash valid for only one request)
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
