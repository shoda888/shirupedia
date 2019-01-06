class UserMailer < ApplicationMailer
  def created_with_email(user, token)
    @url = "http://localhost:3000/profiles/new?token=#{token}" if Rails.env.development?
    @url = "http://titech-shirupedia-stg.herokuapp.com/profiles/new?token=#{token}" if Rails.env.staging?
    @url = "https://www.shirupedia.com/profiles/new?token=#{token}" if Rails.env.production?
    mail(to: user.email, subject: 'welcome to shirupedia')
  end
end
