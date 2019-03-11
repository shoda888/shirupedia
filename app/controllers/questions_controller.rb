class QuestionsController < ApplicationController
  include AjaxHelper
  # protect_from_forgery except: [:create]
  layout 'main_table'
  before_action :authenticate_user, { except: [:newpost, :post, :show] }
  before_action :check_public, { only: [:show] }
  before_action :ensure_correct_user, { only: [:edit, :update, :destroy, :fire] }

  def index
    specialized_by_belongs
    specialized_by_tag
    specialized_by_state
    @questions = @questions.includes([:covers, :taggings, answers: { user: :profile, covers: [comments: :user] }, user: :profile]).page(params[:page]).per(20)
  end

  def new
    @question = Question.new
  end

  def create
    if params[:final_button]
      @question = Question.find(params[:id])
      @question.attributes = question_params
      if @question.save
        # @question.covers.create(:photo_message => File.open("./public/shirupedia_q_info.png"), role: 2)
        @question.covers.create(role: 'text')
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
    @covers = @question.covers
    @answers = @question.answers.includes(:user).order('created_at desc')
    @question_user = @question.user
    @avatar = @question_user.profile.avatar
    @answered_by_me = @answers.find_by(user_id: @current_user.id) if @current_user
    @related_questions = @question.find_related_fields
    @image = if @cover = @covers.find_by(role: 'photo')
               @cover.photo_message.url
             else
               'https://res.cloudinary.com/hnj7qqu7w/image/upload/v1544865660/fllxwb65ayzecqrfup2p.png'
             end
    @ogp = Ogp.new({ title: @question.title.to_s,
                     description: @question.text_message.to_s,
                     image: @image.to_s,
                     card: 'summary' })
  end

  def edit
  end

  def update
    @question.attributes = question_params
    if @question.save
      redirect_to question_path(@question), notice: detect_rooms + '質問を編集しました'
    end
  end

  def destroy
  end

  def fire
    if @question.wanted?
      @question.close!
      redirect_to question_path(@question), notice: '質問を非公開にしました'
    else
      @question.public!
      redirect_to question_path(@question), notice: '質問を公開にしました'
    end
  end

  def newpost
    @question = Question.new
    @ogp = Ogp.new({ title: "Shirupediaに質問を投稿しよう",
                     description: "東工大の各相談室に質問を送ることができます。質問内容を直接入力するか、それ記載したものをフォトメッセージとして送ることができます。",
                     image: 'https://res.cloudinary.com/hnj7qqu7w/image/upload/v1544865660/fllxwb65ayzecqrfup2p.png',
                     card: 'summary' })
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
    @search = params[:search]
    @questions = if @department
                   Question.where(id: Question.where(user_id: Profile.where(department: @department).pluck(:user_id)).ids & search_questions(@search))
                 elsif @school
                   Question.where(id: Question.where(user_id: Profile.where(school: @school).pluck(:user_id)).ids & search_questions(@search))
                 else
                   Question.where(id: search_questions(@search))
                 end
  end

  def specialized_by_state
    @questions = @questions.where(aasm_state: 'wanted').order('created_at desc')
  end

  def search_questions(words)
    return Question.ids unless words.present?
    qids = []
    words.split(/[[:blank:]]+/).each do |w|
      next if w == ""
      qids << Question.where(['title LIKE ? OR text_message LIKE ?', "%#{w}%", "%#{w}%"]).ids
    end
    qids.flatten.uniq
  end

  def question_params
    params.require(:question).permit(:title, :text_message, :field_list)
  end

  def ensure_correct_user
    @question = Question.find(params[:id])
    if @question.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to questions_path
    end
  end

  def check_public
    @question = Question.find(params[:id])
    if @question.closed? && @current_user.id != @question.user_id
      flash[:notice] = "権限がありません"
      redirect_to questions_path
    end
  end
end
