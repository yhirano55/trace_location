# TraceLocation

TraceLocation helps you get tracing the source location of codes, and helps you can get reading the huge open souce libraries in Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'trace_location'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trace_location

## Usage

### Example: Track establish connection in Active Record

```ruby
config = Rails.application.config.database_configuration[Rails.env]

TraceLocation.trace do
  # You just surround you want to track the process.
  ActiveRecord::Base.establish_connection(config)
end
```

Then you can get logs like this: [.md](https://github.com/yhirano55/trace_location/blob/master/examples/active_record_establish_connection/result.md), [.log](https://github.com/yhirano55/trace_location/blob/master/examples/active_record_establish_connection/result.log), [.csv](https://github.com/yhirano55/trace_location/blob/master/examples/active_record_establish_connection/result.csv)

### Trace method options

| name | content | example |
|:-----|:--------|:--------|
| format | `:markdown`, `:log`, `:csv` (default: `:markdown`) | `:markdown` |
| match | Regexp, Symbol, String for allow list | `:activerecord` |
| ignore | Regexp, Symbol, String for deny list | `/bootsnap\|activesupport/ |

## More examples

### Example: Track the validation process of Active Record

```ruby
book = Book.new(title: "My Book Title")
TraceLocation.trace(match: /activerecord/) { book.validate }
```

Results: [.md](https://github.com/yhirano55/trace_location/blob/master/examples/active_record_validation_process/result.md), [.log](https://github.com/yhirano55/trace_location/blob/master/examples/active_record_validation_process/result.log), [.csv](https://github.com/yhirano55/trace_location/blob/master/examples/active_record_validation_process/result.csv)

### Example: Track the lifecycle of Rails application

```ruby
env = Rack::MockRequest.env_for('http://localhost:3000/books')

TraceLocation.trace do
  status, headers, body = Rails.application.call(env)
end
```

Results: [.md](https://github.com/yhirano55/trace_location/blob/master/examples/lifecycle_of_rails_application/result.md), [.log](https://github.com/yhirano55/trace_location/blob/master/examples/lifecycle_of_rails_application/result.log), [.csv](https://github.com/yhirano55/trace_location/blob/master/examples/lifecycle_of_rails_application/result.csv)

### Example: Track the `has_secure_password` in User model

```ruby
class User < ApplicationRecord
  # temporary surrounding with TraceLocation#trace
  Trace.location(format: :markdown, ignore: /activesupport/) do
    has_secure_password
  end
```

Results: [.md](https://github.com/yhirano55/trace_location/blob/master/examples/has_secure_password/result.md), [.log](https://github.com/yhirano55/trace_location/blob/master/examples/has_secure_password/result.log), [.csv](https://github.com/yhirano55/trace_location/blob/master/examples/has_secure_password/result.csv)

### Example: Track the rendering process of action in controller class

```ruby
class BooksController < ApplicationController
  before_action :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    @books = Book.all

    # temporary surrounding with TraceLocation#trace
    TraceLocation.trace(format: :markdown, ignore: /activesupport|rbenv|concurrent-ruby/) do
      render json: @books
    end
  end
```

Results: [.md](https://github.com/yhirano55/trace_location/blob/master/examples/rendering_process/result.md), [.log](https://github.com/yhirano55/trace_location/blob/master/examples/rendering_process/result.log), [.csv](https://github.com/yhirano55/trace_location/blob/master/examples/rendering_process/result.csv)

## License

[MIT License](https://opensource.org/licenses/MIT)
