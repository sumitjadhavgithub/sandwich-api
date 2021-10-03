require 'pusher'
class Api::AnswersController < Api::ApplicationController

    def create
        Answer.create({question_id: params["question_id"], answer: params["answer"]})
        # send_message()
        channel = WebSocket.get_channel(current_user.id, 'user')
        puts "channel details #{channel}"
        WebSocketService.new(WebSocket.get_channel(current_user.id, 'user')).trigger('Answer Submitted', {})
        render_success({success: true})
    # rescue StandardError => e
    #     render_error({ code: 1000, message: "Sorry, something has gone wrong." })
    end

    private 

    def send_message()
        pusher = Pusher::Client.new(
            app_id: '1276051',
            key: 'eacf26f0bc3a1caf0647',
            secret: '20e4119076319b71c760',
            cluster: 'ap2',
            encrypted: true
        )

        pusher.trigger('my-channel', 'my-event', {
            message: 'hello world'
        })
    end
end
