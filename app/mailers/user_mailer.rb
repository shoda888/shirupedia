class UserMailer < ApplicationMailer
  def created_with_email(user, token)
    if Rails.env.development?
      @url = "http://localhost:3000/profiles/new?token=#{token}"
      @deep = "http://localhost:3000/start_up?token=#{token}"
    elsif Rails.env.staging?
      @url = "https://titech-shirupedia-stg.herokuapp.com/profiles/new?token=#{token}"
      @deep = "https://titech-shirupedia-stg.herokuapp.com/start_up?token=#{token}"
    else
      @url = "https://www.shirupedia.com/profiles/new?token=#{token}"
      @deep = "https://www.shirupedia.com/start_up?token=#{token}"
    end
    mail(to: user.email, subject: 'welcome to shirupedia')
  end
end
