require 'sinatra'
require 'haml'
require 'yaml'

set :port, 9494
set :haml, :format => :html5

get '/hi' do
  @testYaml=<<eos
  brand: MenuStrap
  items:
    - url: /home
      name: Home
    - url: /other
      name: Other
      children:
        - url: /one
          name: One
        - url: /two
          name: Two
    - url: /admin
      name: Admin
eos
  @locations = YAML::load(@testYaml)['items']
  @brand = YAML::load(@testYaml)['brand']
  haml :index
end