class UserMailer < ApplicationMailer
  def created_with_email(user)
    @url = 'http://localhost:3000/profiles/new' if Rails.env.development?
    @url = 'http://titech-shirupedia-stg.herokuapp.com/profiles/new' if Rails.env.staging?
    @url = 'http://titech-shirupedia.herokuapp.com/profiles/new' if Rails.env.production?
    mail(to: user.email, subject: 'welcome to shirupedia')
  end
end
