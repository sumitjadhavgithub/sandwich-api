class Api::AnswersController < Api::ApplicationController

    def create
        Answer.create({question_id: params["question_id"], answer: params["answer"]})
        render_success({success: true})
    rescue StandardError => e
        render_error({ code: 1000, message: "Sorry, something has gone wrong." })
    end
end
