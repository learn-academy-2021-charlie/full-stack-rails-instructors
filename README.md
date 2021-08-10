# Full-stack Rails

Setup
- create a Rails app on Desktop
- created db
- add remote from GHCR
- created branch main
- initial commit
- checkout index branch


Index
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
