# Full-stack Rails

Setup
- create a Rails app on Desktop
- created db
- add remote from GHCR
- created branch main
- initial commit
- checkout index branch


### INDEX
- rails g model Herb name:string watered:string
- rails db:migrate
- rails c to add some data
- Herb.create name: 'Thyme', watered: 'no'
- Herb.create name: 'Basil', watered: 'yes'
- Herb.create name: 'Cilantro', watered: 'yes'
- Herb.all - array of db instances
- rails g controller Herb   (named exactly the same as the model)
- create an index method
```ruby
def index
  @herbs = Herb.all
end
```
- create a route `get '/herbs' => 'herb#index'`
- create a view called exactly: index.html.erb
```
<ul>
  <% @herbs.each do |herb| %>
    <li><%= herb.name %></li>
  <% end %>
</ul>
```

### SHOW
- Show: Just one thing from the db
- controller method
def show
  @herb = Herb.find(params[:id])
end
- create a route `get '/herbs/:id' => 'herb#show'`
- create a view called exactly: show.html.erb

Parameters: {"id"=>"1"}
params[:id] ---> 1


Creating Navigation
- Show => Index
- added an alias to the route: `get '/herbs' => 'herb#index', as: 'herbs'`
- reference the alias as the herbs_path
<h4><%= link_to 'Back Home', herbs_path %></h4>
- Index => Show
- added an alias: `get '/herbs/:id' => 'herb#show', as: 'herb'`
- reference the alias as herb_path(herb) <<-- param


### NEW
- New: shows a form
- controller method
```
def new
  @herb = Herb.new
end
```
- create a route `get '/herbs/new' => 'herb#new'`
- created a view using form_with https://guides.rubyonrails.org/form_helpers.html
```
<%= form_with model: @herb, local: true do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>
  <br>
  <br>
  <%= form.label :watered %>
  <%= form.text_field :watered%>
  <br>
  <br>
  <%= form.submit 'Add Herb'%>
<% end %>
```
- Added navigation from index => new, and from new => index


### CREATE
- Create - adding stuff to db
- controller method
```
def create
  @herb = Herb.create(herb_params)
end

private
# Strong params:
def herb_params
  params.require(:herb).permit(:name, :watered)
end
```
- create a route `post '/herbs' => 'herb#create'`
- view: submit button and redirects
```
def create
  @herb = Herb.create(herb_params)
  if @herb.valid?
    redirect_to herbs_path
  else
    redirect_to new_herb_path
  end
end
```
