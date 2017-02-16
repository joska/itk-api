# server.rb
require 'sinatra'
require 'mongoid'
require 'sinatra/namespace'
require "sinatra/reloader" if development?
# require 'sinatra/required_params' @todo make this working

# for accessing API from public (development is in Vagrant image)
set :bind, '0.0.0.0'

# Load MongoDB config file
Mongoid.load! "mongoid.config"

get '/' do
  '<h1>ITk API v1</h1><p><a href="http://docs.itkpd.apiary.io/">Current documentation on Apiary</a></p>'
end


# Beginning of the versiohn namespace, later will be refactored in separate files
namespace '/api/v1' do

  helpers do

    # Sets the base URL for the API
    def baseUrl
      @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
    end

    # Accesses the body of the request
    def requestBody
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message:'The provided JSON is not valid!' }.to_json
      end
    end

  end

  before do
    # startup before every action
    content_type 'application/json'
  end




  post '/component ' do

    # @ToDo switch by component type, reject assembly
    component = Component.new(requestBody)
    if component.save
      response.headers['Location'] = "#{baseUrl}/api/v1/components/#{component.id}"
      # if possible, prefer this always
      # response.headers['Location'] = "#{baseUrl}/api/v1/components/#{component.serialNumber}"
      status 201
    else
      status 422
    end
  end

end





# Models


class Manufacturer
  include Mongoid::Document

  field :name, type: String
  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime

  has_many  :components, validate: false

  index({ name: 'text' })
end


class Institution

  include Mongoid::Document

  field :name, type: String
  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime

  has_many  :components, validate: false

  index({ name: 'text' })
end


class Person
  include Mongoid::Document

  field :name, type: String
  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime

  has_many  :components, validate: false

  index({ name: 'text' })
end




class Comment
  include Mongoid::Document

  belongs_to :component

  field :name, type: String
  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime
  field :author, type: Person
end

class ComponentAttachment
  include Mongoid::Document

  belongs_to :component

  field :name, type: String
  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime
end

class TestAttachment
  include Mongoid::Document

  belongs_to :test

  field :name, type: String
  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime
end





class Test
  include Mongoid::Document

  belongs_to :component

  field :name, type: String
  field :testType, type: String

  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime

  has_many  :testAttachments, validate: false
  has_many  :parameters, validate: false

  field :person, type: Person
  field :passed, type: Boolean

  index({ name: 'text' })
end

class Parameter
  include Mongoid::Document

  belongs_to :test

  field :name, type: String
  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime

  index({ name: 'text' })
end


class ComponentAttribute
  include Mongoid::Document

  belongs_to :component

  field :name, type: String
  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime

  index({ name: 'text' })
end



# Parent class for every component
class Component
  include Mongoid::Document

  store_in collection: 'components'

  # def initialize(json)

  # end

  belongs_to :component
  belongs_to :person
  belongs_to :component, optional: true
  belongs_to :manufacturer

  field :serialNumber, type: String
  field :type, type: String
  field :manufacturerName, type: String
  field :dateCreated, type: DateTime
  field :dateModified, type: DateTime

  field :Institution, type: Institution
  field :Person, type: Person
  field :Manufacturer, type: Manufacturer
  field :Parent, type: Component

  has_many  :comments, validate: false
  has_many  :tests, validate: false
  has_many  :componentAttributes, validate: false
  has_many  :componentAttachments, validate: false

  #Name of the position in the parent assembly
  field :assemblePosition, type: String

  validates :type, presence: true

  index({ manufacturerName: 'text' })
  index({ serialNumber: 'text'}, { unique: true, name: "serialNumber_index" })

end

class Item < Component


  include Mongoid::Document


end

class Batch < Component


  include Mongoid::Document


end

class Assembly < Component


  include Mongoid::Document

  has_many  :components, validate: false

end



