class MatelpageController < ApplicationController
  def index
    @questions = Question.includes([:fields, user: :profile]).order('created_at desc')
  end
end
