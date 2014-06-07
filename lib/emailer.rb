class Emailer
  def self.deliver(email, note)
    mandrill = Mandrill::API.new ENV['MANDRILL_API_KEY']
    message = {
      subject: 'New Password',
      from_name: 'Secret Password Emailer',
      to: [
        {
          email: email
        }
     ],
      html: "<html><p>Someone sent you a password for #{note.name}</p>
            <p><a href=\"ENV['SERVER_URL']/notes/#{note.id}\">click here</a> to see it</p>
            </html>",
      from_email: ENV['FROM_EMAIL']
    }
    mandrill.messages.send message
  end
end
