require 'test_helper'

class WelcomeMailerTest < ActionMailer::TestCase
  def sample_mail_preview
    WelcomeMailer.creation_email(Project.first)
  end
  def track_mail_preview
    WelcomeMailer.track_email(Project.first)
  end
# test "the truth" do
  #   assert true
  # end
end
