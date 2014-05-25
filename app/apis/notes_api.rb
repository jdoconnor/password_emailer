class NotesApi < Grape::API
  desc 'create a new note'
  params do
    requires :name, type: String
    requires :secret, type: String
  end
  post do
    note = Note.new(name: params.name, secret: params.secret)
    note.save
    { status: :ok }
  end

  route_param :id do
    desc 'Get an note'
    get do
      note = Note.find(params.id)
      { data: { name: note.name, secret: note.decrypted_secret } }
    end
  end
end
