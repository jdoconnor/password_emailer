class NotesApi < Grape::API
  desc 'create a new note'
  params do
    requires :name, type: String
    requires :secret, type: String
    requires :email, type: String
    optional :expires_in_seconds, type: Integer, default: 86400
  end
  post do
    note = Note.new(name: params.name, secret: params.secret, expires_in_seconds: params.expires_in_seconds)
    note.save
    Emailer.deliver(params.email, note)
    { id: note.id }
  end

  route_param :id do
    desc 'Get an note'
    get do
      note = Note.find(params.id)
      { data: { name: note.name, secret: note.decrypted_secret } }
    end
  end
end
