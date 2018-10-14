class UserMailer < ApplicationMailer
  def created_with_email(user)
    @url = 'http://localhost:3000/profiles/new'
    mail(to: user.email, subject: 'welcome to shirupedia')
  end
end
