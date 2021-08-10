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
```ruby
def create
  @herb = Herb.create(herb_params)
  if @herb.valid?
    redirect_to herbs_path
  else
    redirect_to new_herb_path
  end
end
```


### DESTROY
- Destory - removing an item from the db
- controller method
```ruby
def destroy
  @herb = Herb.find(params[:id])
  if @herb.destroy
    redirect_to herbs_path
  else
    redirect_to herb_path(@herb)
  end
end
```
- create a route `delete '/herbs/:id' => 'herb#destroy', as: 'delete_herb'`
- view is a button on the show page `<h4><%= link_to 'Delete Herb', delete_herb_path(@herb), method: :delete %></h4>`

### EDIT
- Edit - gives us a form to make changes to an existing item
- controller method
```
def edit
  @herb = Herb.find(params[:id])
end
```
- create a route `get '/herbs/:id/edit' => 'herb#edit', as: 'edit_herb'`
- create a view: edit.html.erb
```
<h2>Update an Herb</h2>

<%= form_with model: @herb, method: :patch, local: true do |form| %>
  <%= form.label :name %>
  <%= form.text_field :name %>
  <br>
  <br>
  <%= form.label :watered %>
  <%= form.text_field :watered%>
  <br>
  <br>
  <%= form.submit 'Edit Herb'%>
<% end %>
<br>
<br>
<h4><%= link_to 'Back Home', herbs_path %></h4>
```
- navigation from show => edit
```
<h4>
  <%= link_to 'Edit Herb', edit_herb_path(@herb) %>
</h4>
```

### UPDATE
- Update: modifies one instance in the db
- controller method
```ruby
def update
  @herb = Herb.find(params[:id])
  @herb.update(herb_params)
  if @herb.valid?
    redirect_to herb_path(@herb)
  else
    redirect_to edit_herb_path(@herb)
  end
end
```
- create a route `patch 'herbs/:id' => 'herb#update'`
