class Api::UsersController < Api::ApplicationController
    skip_before_action :doorkeeper_authorize!, only: %i[create]


    def create 
        @user = User.new(email: user_params[:email], password: user_params[:password])
        @client_app = Doorkeeper::Application.find_by(uid: params[:client_id])

        return render_error({ message: 'Client id is invalid', code: 1002}) unless @client_app

        if @user.save
            render_create_success
        else
            error_message =  'Sign up failed'
            if @user.errors.full_messages.present?
                error_message = @user.errors.full_messages
            end
            render_error({ message: error_message, code: 1000})
        end
    rescue StandardError => e
        log_error(e)
        render_error({ code: 1000, message: "Sorry, something has gone wrong." }, nil, false)
    end


    def render_create_success
        token_details = DoorkeeperService.new(@user, @client_app).generate_access_token
        render json: token_details
    end

    private

    def user_params
        params.permit(:email, :password)
    end
end
