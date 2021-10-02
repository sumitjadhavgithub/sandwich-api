class Api::QuestionsController < Api::ApplicationController

    def create
        current_user.questions.create({name: params[:name]})
        render_success ({success: true})
    rescue StandardError => e
        render_error({ code: 1000, message: "Sorry, something has gone wrong." })
    end

    def get_questions
        render_success ({questions: current_user.questions})
    rescue StandardError => e
        render_error({ code: 1000, message: "Sorry, something has gone wrong." })
    end

    def get_answers
        render_success ({answers: question.answers})
    rescue StandardError => e
        render_error({ code: 1000, message: "Sorry, something has gone wrong." })

    end

    private

    def question
      current_user.questions.find(params[:id])
    end
end
