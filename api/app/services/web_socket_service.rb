require 'pusher'

class WebSocketService
    def initialize(socket_channel)
        @channel = socket_channel
    end

    def trigger(event, data = {})
        return nil unless @channel.present?
        merged_data = {
          user_id: @channel.user.id
        }.merge(data)
        send(@channel.channel_name, event, merged_data)
    end

    private 

    def send(channel, event, data)
        AsyncJob.perform_async(lambda do
            begin
                Pusher.trigger channel, event, data
            rescue StandardError => e
                puts "Error #{e}"
            end
        end)
    end
end
