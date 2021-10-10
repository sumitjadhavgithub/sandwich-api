class Api::ApplicationController < ActionController::API
    before_action :doorkeeper_authorize!

    def render_json(success, data = nil, error = {code: 1000, message: 'An error has occurred'})
        response_json = {}

        if success
            response_json = {
                success: success
            }.merge(data)
        else
            response_json = {
                error: {
                    code: error[:code],
                    message: error[:message],
                    data: data == nil ? {} : data
                }
            }
        end
        render json: response_json
    end

    def render_success(data = nil)
        render_json(true, data)
    end
    
    def render_error(error, data = nil, save_to_db = true)
        render_json(false, data, error)
    end
    
    def doorkeeper_unauthorized_render_options(error:)
        return {:json => {error: {code: 1001, message: 'Not authorized'} }}
    end

    private

    def current_user
        @current_user ||= (User.find_by(id: doorkeeper_token[:resource_owner_id]) if doorkeeper_token)
    end
end
