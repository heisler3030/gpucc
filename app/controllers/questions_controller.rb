class QuestionsController < ApplicationController
  skip_authorization_check

  before_filter {@blockscore = BlockScore::Client.new(ENV['BLOCKSCORE_KEY'], version = 2)}

  def show
    @user = current_user
    @questions = @blockscore.get_question_set(params[:id])
    puts @questions.inspect
  end

end
