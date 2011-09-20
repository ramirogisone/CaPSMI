class UserSessionsController < ApplicationController

  def new
		@user_session = UserSession.new
		session[:opcion] = nil
  end

  def create
		@user_session = UserSession.new(params[:user_session])
		if @user_session.save
			if session[:return_to]
	  			redirect_back_or_default
			else
				redirect_to :root
			end
		else
	  		render :action => :new
		end
  end

  def destroy
		current_user_session.destroy if current_user_session
		redirect_to :root
  end

end
