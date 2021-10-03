require 'pusher'

class WebSocketService
    def initialize(socket_channel)
        @channel = socket_channel
    end

    def trigger(event, data = {})
        puts "sumit ----- came here 3"
        return nil unless @channel.present?
        merged_data = {
          user_id: @channel.user.id
        }.merge(data)
        puts "sumit ----- came here 4 #{@channel}"
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
