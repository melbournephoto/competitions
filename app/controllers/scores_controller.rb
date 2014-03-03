class ScoresController < ApplicationController
  def index

  end

  def show
    @grade = Grade.find(params[:id])

    @scores = Score.new(@grade)
  end
end
