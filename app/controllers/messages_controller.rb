class MessagesController < ApplicationController
  def index
    @messages = Message.all
    @users = User.all
  end

  def create
    puts 'creating a message...'
    @message = Message.create message_params
    PrivatePub.publish_to("/messages/new", message: @message)
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
