class WebSocket < ApplicationRecord
    belongs_to :user

    def channel_name
        WebSocket.channel_name(uuid, channel_type)
    end

    def self.channel_name(uuid, channel_type = 'user')
        "#{uuid}_#{channel_type}"
    end

    def self.get_channel(user_id, type = 'user')
        uuid = WebSocket.uuid_from_user_id(user_id).presence || SecureRandom.hex(nil)
        WebSocket.find_or_create_by(user_id: user_id, uuid: uuid, channel_type: type)
    end

    def self.uuid_from_user_id(user_id)
        channel = WebSocket.find_by(user_id: user_id)
        channel.uuid if channel.present?
    end
end
