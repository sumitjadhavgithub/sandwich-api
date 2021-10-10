require 'pusher'
class Api::AnswersController < Api::ApplicationController

    def create
        Answer.create({question_id: params["question_id"], answer: params["answer"]})
        channel = WebSocket.get_channel(current_user.id, 'user')
        puts "channel details #{channel}"
        WebSocketService.new(WebSocket.get_channel(current_user.id, 'user')).trigger('answer_added', {})
        render_success({success: true})
    rescue StandardError => e
        render_error({ code: 1000, message: "Sorry, something has gone wrong." })
    end
end
