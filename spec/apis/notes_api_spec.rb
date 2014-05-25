require 'spec_helper'

def app
  ApplicationApi
end

def data
  Hashie::Mash.new(JSON.parse(last_response.body))
end

describe NotesApi do
  include Rack::Test::Methods

  describe 'GET /notes/:id' do
    before do
      @note = Note.new(name: 'myname', secret: 'mysecret').save
    end

    it 'returns a decrypted secret' do
      get "/notes/#{@note.id}"
      expect(data.data.name).to eq('myname')
      expect(data.data.secret).to eq('mysecret')
    end

    it 'only fetches once' do
      get "/notes/#{@note.id}"
      get "/notes/#{@note.id}"
      expect(data.data.name).to be(nil)
      expect(data.data.secret).to be(nil)
    end
  end

  describe 'POST /notes' do
    it 'encrypts before saving to redis' do
      Redis.any_instance.should_receive(:set) do |key, value|
        expect(key).to_not be(nil)
        expect(JSON.parse(value)['name']).to eq('myname')
        expect(JSON.parse(value)['mysecret']).to_not eq('mysecret')
      end
      post '/notes', name: 'myname', secret: 'mysecret'
    end
  end

end
