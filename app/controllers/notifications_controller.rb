class NotificationsController < ApplicationController

  def index
    @notifications = current_user.notifications
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def new
  	@notification = Notification.new
  end

  def create
   
    @notification = Notification.new(notification_params)
    @notification.date = Time.now
    @notification.first_name = current_user.first_name
    # Get the group, using the group id from the form
    # Associate each user in the group with the notification

    if @notification.save
      @group = Group.find(params[:group][:group_id])
      @users = @group.users
      @users.each do |user|
      @notification.users << user
    end
      flash[:success] = "Notification created!"
      redirect_to notifications_url
    else
      render 'new'
    end
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def destroy
    Notification.find(params[:id]).destroy
    flash[:success] = "Notification deleted"
    redirect_to notifications_url
  end 

  private

    def notification_params
      params.require(:notification).permit(:title, :first_name, :content, :group_id)
    end
end
