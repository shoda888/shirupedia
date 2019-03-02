class UserMailer < ApplicationMailer
  def created_with_email(user, token)
    if Rails.env.development?
      @url = "http://localhost:3000/profiles/new?token=#{token}"
      @deep = "shirupedia://profiles/new?token=#{token}"
    elsif Rails.env.staging?
      @url = "http://titech-shirupedia-stg.herokuapp.com/profiles/new?token=#{token}"
      @deep = "shirupedia://profiles/new?token=#{token}"
    else
      @url = "https://www.shirupedia.com/profiles/new?token=#{token}"
      @deep = "shirupedia://profiles/new?token=#{token}"
    end
    mail(to: user.email, subject: 'welcome to shirupedia')
  end
end
