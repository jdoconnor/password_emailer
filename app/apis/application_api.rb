class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  mount NotesApi => '/notes'

  add_swagger_documentation
end
