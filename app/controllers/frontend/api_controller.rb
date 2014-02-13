class Frontend::ApiController < Frontend::ApplicationController
  def send_contact
    contact = params[:contact]
    c = Contact.new
    c.email = contact['email']
    c.subject = contact['subject']
    c.body = contact['body']
    ContactMailer.contact_mail(c).deliver
    redirect_to contact_path
  end

  def download_event_pdf
    send_file File.join(Rails.root, 'app', 'assets', 'pdfs', 'event_flyer.pdf')
  end
end
