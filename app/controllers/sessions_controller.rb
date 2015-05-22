class SessionsController < ApplicationController
  def new
    maybe_login_from_token
  end

  def create
    email = (params[:session][:email]).downcase
    if user = User.find_by(email: email)
      #email link
    else
      flash.now[:error] =
        "Sorry, but I can't find #{email}. Are you sure that's correct?"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to :root
  end

  private

  def maybe_login_from_token
    return if params[:token].blank?

    user = User.find_by(id: params[:sid])
    password = params[:token]

    if user && user.password_digest && user.authenticate(password)
      flash[:success] = "Logged in!"
      log_in user
      remember user
      path = :root # TODO - redirect to organization
    else
      flash.now[:error] = "Looks like that login link has expired.
        Please request a new one"
      path = request.path
    end

    redirect_to path, params.except(:sid, :token, :action, :controller)
  end
end
