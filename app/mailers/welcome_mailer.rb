class WelcomeMailer < ApplicationMailer
  
  def creation_email(project)
    @recipiants = ''
    @contact = ''
    project.participants.each do |participant|
      @recipiants += participant.contact.email + ','
      @contact += participant.contact.first_name.slice(0,1).capitalize + participant.contact.first_name.slice(1..-1) + ', '
    end
    @contact = @contact[0..-1]
    @project = project
    mail(to: @recipiants, subject: 'RUBRIK C, Création de votre projet')
  end
  
  def track_email(project)
    @recipiants = ''
    @contact = ''
    project.participants.each do |participant|
      @recipiants += participant.contact.email + ','
      @contact += participant.contact.first_name.slice(0,1).capitalize + participant.contact.first_name.slice(1..-1) + ', '
    end
    @contact = @contact[0..-1]
    @project = project
    mail(to: @recipiants, subject: 'RUBRIK C, Suivi de livraison')
  end
end
