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

You just surround the code which you want to track the process.
For example, when you want to track **the lifecycle of Rails application request/response**:

```
% bin/rails c

irb(main):001:0> env = Rack::MockRequest.env_for('http://localhost:3000/api/stories')
irb(main):002:0> TraceLocation.trace { status, headers, body = Rails.application.call(env) }
Created at /path/to/sampleapp/log/trace_location-2019050105051556706139.log
=> true
```

Then you can get a log like this:

```
Logged by TraceLocation gem at 2019-05-01 05:22:19 -0500
https://github.com/yhirano55/trace_location

[Tracing events] C: Call, R: Return

R <internal:prelude>:138#enable
C /vendor/bundle/gems/railties-5.2.3/lib/rails.rb:39#application
R /vendor/bundle/gems/railties-5.2.3/lib/rails.rb:41#application
C /vendor/bundle/gems/railties-5.2.3/lib/rails/engine.rb:522#call
  C /vendor/bundle/gems/railties-5.2.3/lib/rails/application.rb:607#build_request
    C /vendor/bundle/gems/railties-5.2.3/lib/rails/engine.rb:705#build_request
      C /vendor/bundle/gems/railties-5.2.3/lib/rails/application.rb:247#env_config
      R /vendor/bundle/gems/railties-5.2.3/lib/rails/application.rb:275#env_config
      C /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/request.rb:59#initialize
        C /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:40#initialize
          C /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/url.rb:186#initialize
            C /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/filter_parameters.rb:34#initialize
            R /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/filter_parameters.rb:39#initialize
          R /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/url.rb:190#initialize
        R /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:43#initialize
      R /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/request.rb:67#initialize
      C /vendor/bundle/gems/railties-5.2.3/lib/rails/engine.rb:534#routes
      R /vendor/bundle/gems/railties-5.2.3/lib/rails/engine.rb:538#routes
      C /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/request.rb:142#routes=
        C /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:68#set_header
        R /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:70#set_header
      R /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/request.rb:144#routes=
      C /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:129#script_name
        C /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:52#get_header
        R /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:54#get_header
      R /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:129#script_name
      C /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/request.rb:150#engine_script_name=
        C /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/http/request.rb:138#routes
          C /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:52#get_header
          R /vendor/bundle/gems/rack-2.0.7/lib/rack/request.rb:54#get_header
..................
(an omission)
..................
                R /vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/middleware/static.rb:128#call
                C /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:9#respond_to?
                  C /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:9#respond_to?
                    C /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:9#respond_to?
                      C /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:9#respond_to?
                        C /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:9#respond_to?
                        R /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:15#respond_to?
                      R /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:15#respond_to?
                    R /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:15#respond_to?
                  R /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:15#respond_to?
                R /vendor/bundle/gems/rack-2.0.7/lib/rack/body_proxy.rb:15#respond_to?
              R /vendor/bundle/gems/rack-2.0.7/lib/rack/sendfile.rb:140#call
            R /vendor/bundle/gems/railties-5.2.3/lib/rails/engine.rb:525#call

Result: [200, {"Content-Type"=>"application/json; charset=utf-8", "ETag"=>"W/\"42334f8fba25471804e2cfa66fa989a7\"", "Cache-Control"=>"max-age=0, private, must-revalidate", "X-Request-Id"=>"f30153ff-3446-453a-a547-34c4b3766bfc", "X-Runtime"=>"0.455604"}, #<Rack::BodyProxy:0x00007f957960a430 @body=#<Rack::BodyProxy:0x00007f957f1c1f08 @body=#<Rack::BodyProxy:0x00007f957f1a8c10 @body=#<Rack::BodyProxy:0x00007f957f198040 @body=#<Rack::BodyProxy:0x00007f957f17bf58 @body=["[{\"id\":1,\"title\":\"The boy who cried 'wolf!'\",\"parentId\":1},{\"id\":2,\"title\":\"story 2\",\"parentId\":4},{\"id\":3,\"title\":\"story 3\",\"parentId\":null},{\"id\":4,\"title\":\"story 4\",\"parentId\":null},{\"id\":5,\"title\":\"story 1\",\"parentId\":null},{\"id\":6,\"title\":\"story 6\",\"parentId\":null},{\"id\":7,\"title\":\"story 7\",\"parentId\":null},{\"id\":8,\"title\":\"story 8\",\"parentId\":null},{\"id\":9,\"title\":\"story 9\",\"parentId\":null},{\"id\":10,\"title\":\"story 10\",\"parentId\":null},{\"id\":11,\"title\":\"story 11\",\"parentId\":null},{\"id\":12,\"title\":\"story 12\",\"parentId\":null},{\"id\":13,\"title\":\"story 13\",\"parentId\":null}]"], @block=#<Proc:0x00007f957f17ae78@/path/to/sampleapp/vendor/bundle/gems/rack-2.0.7/lib/rack/etag.rb:30>, @closed=false>, @block=#<Proc:0x00007f957f1a2d38@/path/to/sampleapp/vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/middleware/executor.rb:15>, @closed=false>, @block=#<Proc:0x00007f957f1b3728@/path/to/sampleapp/vendor/bundle/gems/railties-5.2.3/lib/rails/rack/logger.rb:39>, @closed=false>, @block=#<Proc:0x00007f957f1c07c0@/path/to/sampleapp/vendor/bundle/gems/activesupport-5.2.3/lib/active_support/cache/strategy/local_cache_middleware.rb:30>, @closed=false>, @block=#<Proc:0x00007f95796096c0@/path/to/sampleapp/vendor/bundle/gems/actionpack-5.2.3/lib/action_dispatch/middleware/executor.rb:15>, @closed=false>]
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
