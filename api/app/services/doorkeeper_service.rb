class DoorkeeperService
  
    def initialize(user, client_app)
      @user = user
      @client_app = client_app
    end

    def generate_access_token 
        access_token = Doorkeeper::AccessToken.create(
            resource_owner_id: @user.id,
            application_id: @client_app.id,
            refresh_token: generate_refresh_token,
            expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
            scopes: ''
        )

        return {
            access_token: access_token.token,
            token_type: "Bearer",
            expires_in: access_token.expires_in,
            refresh_token: access_token.refresh_token,
            created_at: access_token.created_at.to_time.to_i
        }
    end   

    def generate_refresh_token
        loop do
            token = SecureRandom.hex(32)
            break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
        end
    end 
end