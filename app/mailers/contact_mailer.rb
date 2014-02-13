class ContactMailer < ActionMailer::Base
  default from: "kontakt@koehlers-landgasthaus.de"

  def contact_mail(contact)
    @contact = contact
    mail(to: 'landgasthauskoehler@gmail.com', subject: contact.subject)
  end
end
