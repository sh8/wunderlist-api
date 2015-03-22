# Wunderlist::Api

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'wunderlist-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wunderlist-api

## Usage

```
# You must create API CLIENT at first.
wl = Wunderlist::API.new({
:access_token => <your access token>,
:client_id => <your client id>
})

# You can create Task
wl.create_task(LIST_NAME, {'title' => 'Hello World', 'completed' => true, 'due_date' => '2015-03-25' })

# You can get Wunderlist::Task Object
task = wl.tasks([LIST_NAME])[0]
=> #<Wunderlist::Task:0x00000000000> 

# You can create and update note.
task.notes.each do |note|
  note.content = "Hello World"
  note.update
end

=> #<Wunderlist::Note:0x00000000000>

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/wunderlist-api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
# wunderlist-api
