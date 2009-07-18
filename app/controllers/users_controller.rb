class UsersController < ApplicationController
  
  # render new.rhtml
  def new
    @user = User.new
    @participants = Participant.find(:all)
  end
 
  def create
    logout_keeping_session!
    if params[:user][:participant]
      @participant = Participant.find(params[:user][:participant])
      # Once we have participant form attributes partial rendered on the same page, update attributes
      # @participant.update_attributes(params[])
    else
      # Once we have participant form attributes partial rendered on the same page, use form params to create new obj
      @participant = Participant.new()
    end 
    success = @participant && @participant.save
    if success && @participant.errors.empty?
      @user = User.new(params[:user])
      @user.participant = @participant
      success = @user && @user.save
      if success && @user.errors.empty?
        # Protects against session fixation attacks, causes request forgery
        # protection if visitor resubmits an earlier form using back
        # button. Uncomment if you understand the tradeoffs.
        # reset session
        redirect_to 
        flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      else
        @participants = Participant.find(:all)
        flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
        render :action => 'new'
      end
    else
      @participants = Participant.find(:all)
      flash[:error] = "Problem with participant creation, please try again"
      render :action => 'new'
    end
  end
end
