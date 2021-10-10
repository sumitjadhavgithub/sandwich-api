class Api::QuestionsController < Api::ApplicationController

    def create
        current_user.questions.create({name: params[:name]})
        render_success ({success: true})
    rescue StandardError => e
        render_error({ code: 1000, message: "Sorry, something has gone wrong." })
    end

    def get_questions
        WebSocketService.new(WebSocket.get_channel(current_user.id, 'user'))
        render_success ({questions: Question.first})
    rescue StandardError => e
        render_error({ code: 1000, message: "Sorry, something has gone wrong." })
    end

    def get_answers
        render_success ({answers: Question.first.answers.last(100)})
    rescue StandardError => e
        render_error({ code: 1000, message: "Sorry, something has gone wrong." })

    end

    private

    def question
      current_user.questions.find(params[:id])
    end
end
