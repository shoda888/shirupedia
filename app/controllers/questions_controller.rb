class QuestionsController < ApplicationController
  include AjaxHelper
  # protect_from_forgery except: [:create]
  layout 'main_table'
  before_action :authenticate_user, { except: [:newpost, :post] }
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy] }

  def index
    specialized_by_belongs
    specialized_by_tag
    @questions = @questions.includes([:covers, :taggings, answers: { user: :profile, covers: [comments: :user] }, user: :profile]).order('created_at desc').page(params[:page]).per(30)
  end

  def new
    @question = Question.new
  end

  def create
    if params[:final_button]
      @question = Question.find(params[:id])
      @question.attributes = question_params
      if @question.save
        flash[:notice] = detect_rooms + "質問を投稿しました"
        respond_to do |format|
          format.js { render ajax_redirect_to(question_path(@question)) }
        end
      end
    else
      @question = Question.new(user_id: @current_user.id)
      @question.attributes = question_params
      render :imgcreate if @question.save
    end
  end

  def show
    @question = Question.find(params[:id])
    @covers = @question.covers
    @answers = @question.answers.includes(:user).order('created_at desc')
    @question_user = @question.user
    @avatar = @question_user.profile.avatar.thumb
    @answered_by_me = @answers.find_by(user_id: @current_user.id)
    @related_questions = @question.find_related_fields
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.attributes = question_params
    if @question.save
      redirect_to question_path(@question), notice: detect_rooms + '質問を編集しました'
    end
  end

  def destroy
  end

  def fire
    @answer = Answer.find(params[:id])
    @question = @answer.question
    @question.finish!
    redirect_to question_path(@question), notice: '質問が終了しました'
  end

  def newpost
    @question = Question.new
    @ogp = Ogp.new({ title: "Shirupediaに質問を投稿しよう", description: "東工大の各相談室に質問を送ることができます。質問内容を直接入力するか、それ記載したものをフォトメッセージとして送ることができます。", image: "https://res.cloudinary.com/hnj7qqu7w/image/upload/v1544865660/fllxwb65ayzecqrfup2p.png", card: "summary" })
    render layout: 'home'
  end

  def post
    if params[:final_button]
      @question = Question.find(params[:id])
      @question.attributes = question_params
      if @question.save
        flash[:notice] = detect_rooms + "質問を投稿しました"
        respond_to do |format|
          format.js { render ajax_redirect_to(root_path) }
        end
      end
    else
      @question = Question.new(user_id: 1)
      @question.attributes = question_params
      render :imgpost if @question.save
    end
  end

  private

  def detect_rooms
    rooms = []
    @question.field_list.each do |list|
      rooms << list if list.match?(/相談室/)
    end
    str = rooms.join("・")
    str += 'への' if str.present?
    str
  end

  def specialized_by_tag
    @fields = params[:fields]
    if @fields.present?
      @questions = @questions.tagged_with(@fields.split, any: true)
    end
  end

  def specialized_by_belongs
    @school = params[:school]
    @department = params[:department]
    @questions = if @department
                   Question.find_same_department_questions_exclude_mine(params[:department], @current_user.id).search(params[:search])
                 elsif @school
                   Question.find_same_school_questions_exclude_mine(params[:school], @current_user.id).search(params[:search])
                 else
                   Question.search(params[:search])
                 end
  end

  def question_params
    params.require(:question).permit(:title, :text_message, :field_list)
  end

  def ensure_correct_user
  end
end
