class ChatController < ApplicationController
before_action :set_room
    
 def chat
   @room_id = @room.id
   p "으쌰"
    @room.chats.create(user_id: current_user.id, message: params[:message])
 end
 
 def open_chat
   p "오픈챗 됬다."
   @room.update(room_state: true)
   Pusher.trigger("room_#{@room.id}", 'chat_start', {})
 end
 
 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:room_title, :max_count, :room_state, :admissions_count, :meet_time_end, :start_time_hour, :start_time_min, :food_type, :room_type, :hashtag)
    # {room_title: params[:room][:room]
    end
end
