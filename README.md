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

### Example 01. Track the lifecycle of Rails application


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

### Example 02. Track the validation process of Active Record

```
% bin/rails c

irb(main):001:0> book = Book.new(title: "My Book Title")
irb(main):002:0> TraceLocation.trace { book.validate }
Created at /path/to/sampleapp/log/trace_location-2019050104049576006131.log
=> true
```

Then you can get a log like this:

```
TraceLocation at 2019-05-01 04:49:57 -0500
[Tracing events] C: Call, R: Return

R <internal:prelude>:138#enable
C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/validations.rb:65#valid?
  C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/validations.rb:75#default_validation_context
    C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/persistence.rb:231#new_record?
      C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/transactions.rb:490#sync_with_transaction_state
        C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/transactions.rb:494#update_attributes_from_transaction_state
        R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/transactions.rb:500#update_attributes_from_transaction_state
      R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/transactions.rb:492#sync_with_transaction_state
    R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/persistence.rb:234#new_record?
  R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/validations.rb:77#default_validation_context
  C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:336#valid?
    C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:303#errors
      C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:74#initialize
        C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:470#apply_default_array
        R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:473#apply_default_array
        C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:470#apply_default_array
        R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:473#apply_default_array
      R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:78#initialize
    R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:305#errors
    C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:115#clear
    R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:118#clear
    C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/callbacks.rb:117#run_validations!
      C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:815#_run_validation_callbacks
        C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:94#run_callbacks
          C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:124#__callbacks
            C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:106#__callbacks
            R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:128#__callbacks
          R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:95#__callbacks
          C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:539#empty?
          R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:539#empty?
          C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:563#compile
            C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:473#initialize
            R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:480#initialize
            C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:334#apply
              C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:374#conditions_lambdas
              R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:377#conditions_lambdas
              C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:447#build
                C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:383#initialize
                R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:388#initialize
              R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:466#build
              C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:423#make_lambda
              R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:428#make_lambda
              C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:213#build
                C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:244#halting
                  C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:487#after
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:490#after
                R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:252#halting
              R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:227#build
            R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:346#apply
          R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:570#compile
          C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:504#final?
          R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:506#final?
          C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:512#invoke_before
          R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:514#invoke_before
          C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:408#run_validations!
            C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:815#_run_validate_callbacks
              C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:94#run_callbacks
                C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:124#__callbacks
                  C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:106#__callbacks
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/class/attribute.rb:128#__callbacks
                R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:95#__callbacks
                C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:539#empty?
                R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:539#empty?
                C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:563#compile
                  C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:473#initialize
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:480#initialize
                  C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:334#apply
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:374#conditions_lambdas
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:377#conditions_lambdas
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:447#build
                      C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:348#current_scopes
                      R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:350#current_scopes
                      C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:383#initialize
                      R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:388#initialize
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:466#build
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:423#make_lambda
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:428#make_lambda
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:162#build
                      C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:191#halting
                        C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:482#before
                        R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:485#before
                      R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:208#halting
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:170#build
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:346#apply
                  C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:334#apply
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:374#conditions_lambdas
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:377#conditions_lambdas
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:447#build
                      C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:348#current_scopes
                      R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:350#current_scopes
                      C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:383#initialize
                      R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:388#initialize
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:466#build
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:423#make_lambda
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:428#make_lambda
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:162#build
                      C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:191#halting
                        C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:482#before
                        R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:485#before
                      R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:208#halting
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:170#build
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:346#apply
                  C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:334#apply
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:374#conditions_lambdas
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:377#conditions_lambdas
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:447#build
                      C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:383#initialize
                      R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:388#initialize
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:466#build
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:423#make_lambda
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:428#make_lambda
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:162#build
                      C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:191#halting
                        C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:482#before
                        R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:485#before
                      R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:208#halting
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:170#build
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:346#apply
                R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:570#compile
                C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:504#final?
                R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:506#final?
                C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:512#invoke_before
                  C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:403#expand
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:419#expand
                  C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:153#validate_associated_records_for_pages
                    C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:313#validate_collection_association
                      C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/associations.rb:270#association_instance_get
                      R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/associations.rb:272#association_instance_get
                    R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:319#validate_collection_association
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:426#validate_associated_records_for_pages
                  C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:403#expand
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:419#expand
                  C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:148#validate
                    C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:37#__temp__479647c656
                      C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:76#_read_attribute
                        C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:47#fetch_value
                          C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:15#[]
                          R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:17#[]
                          C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute.rb:40#value
                          R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute.rb:44#value
                        R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:49#fetch_value
                      R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:78#_read_attribute
                    R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:41#__temp__479647c656
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/object/blank.rb:57#blank?
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/object/blank.rb:59#blank?
                  R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:154#validate
                  C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:403#expand
                  R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:419#expand
                  C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:148#validate
                    C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:37#__temp__3757d6d6162797
                      C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:76#_read_attribute
                        C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:47#fetch_value
                          C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:15#[]
                          R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:17#[]
                          C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute.rb:40#value
                          R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute.rb:44#value
                        R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/attribute_set.rb:49#fetch_value
                      R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:78#_read_attribute
                    R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/attribute_methods/read.rb:41#__temp__3757d6d6162797
                    C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/object/blank.rb:57#blank?
                    R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/core_ext/object/blank.rb:59#blank?
                  R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:154#validate
                R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:514#invoke_before
                C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:516#invoke_after
                R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:518#invoke_after
              R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:139#run_callbacks
            R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:817#_run_validate_callbacks
            C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:303#errors
            R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:305#errors
            C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:209#empty?
              C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:179#size
                C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:188#values
                R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:192#values
              R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:181#size
            R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:211#empty?
          R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:411#run_validations!
          C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:516#invoke_after
            C /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:403#expand
            R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:419#expand
            C /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:492#_ensure_no_duplicate_errors
              C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:303#errors
              R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:305#errors
            R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/autosave_association.rb:496#_ensure_no_duplicate_errors
          R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:518#invoke_after
        R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:139#run_callbacks
      R /vendor/bundle/gems/activesupport-5.2.3/lib/active_support/callbacks.rb:817#_run_validation_callbacks
    R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/callbacks.rb:119#run_validations!
  R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:342#valid?
  C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:303#errors
  R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:305#errors
  C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:209#empty?
    C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:179#size
      C /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:188#values
      R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:192#values
    R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:181#size
  R /vendor/bundle/gems/activemodel-5.2.3/lib/active_model/errors.rb:211#empty?
R /vendor/bundle/gems/activerecord-5.2.3/lib/active_record/validations.rb:69#valid?

Result: true
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
