require 'sinatra'
require 'haml'
require 'yaml'

set :port, 9494
set :haml, :format => :html5

def haml_tag_if(condition, *args, &block)
  if condition
    haml_tag *args, &block
   else
     yield
   end
end

get '/' do
  @yaml=<<eos
brand: MenuStrap
items:
  - url: /home
    name: Home
    icon: home
  - url: /other
    name: Other
    children:
      - url: /one
        name: One
      - url: /two
        name: Two
  - url: /admin
    name: Admin
right_items:
  - url: /home
    name: Home
eos
  @locations = YAML::load(@yaml)['items']
  @right_locations = YAML::load(@yaml)['right_items']
  @brand = YAML::load(@yaml)['brand']
  @container = false
  haml :index
end

post '/' do
  @yaml = params['yaml']
  @locations = YAML::load(@yaml)['items']
  @right_locations = YAML::load(@yaml)['right_items']
  @brand = YAML::load(@yaml)['brand']
  @container = YAML::load(@yaml)['container']
  haml :index
end