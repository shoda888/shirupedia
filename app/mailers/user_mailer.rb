class UserMailer < ApplicationMailer
  def created_with_email(user)
    mail(to: user.email, subject: 'welcome to shirupedia')
  end
end
