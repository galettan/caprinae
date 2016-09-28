# Preview all emails at http://localhost:3000/rails/mailers/welcome_mailer
class WelcomeMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    WelcomeMailer.creation_email(Project.first)
  end
  def track_mail_preview
    WelcomeMailer.track_email(Project.first)
  end

end
