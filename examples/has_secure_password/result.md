Generated by [trace_location](https://github.com/yhirano55/trace_location) at 2019-06-08 01:28:44 +0900

<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/secure_password.rb:55</summary>

##### ActiveModel::SecurePassword::ClassMethods.has_secure_password

```ruby
def has_secure_password(options = {})
  # Load bcrypt gem only when has_secure_password is used.
  # This is to avoid ActiveModel (and by extension the entire framework)
  # being dependent on a binary library.
  begin
    require "bcrypt"
  rescue LoadError
    $stderr.puts "You don't have bcrypt installed in your application. Please add it to your Gemfile and run bundle install"
    raise
  end

  include InstanceMethodsOnActivation

  if options.fetch(:validations, true)
    include ActiveModel::Validations

    # This ensures the model has a password by checking whether the password_digest
    # is present, so that this works with both new and existing records. However,
    # when there is an error, the message is added to the password attribute instead
    # so that the error message will make sense to the end-user.
    validate do |record|
      record.errors.add(:password, :blank) unless record.password_digest.present?
    end

    validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
    validates_confirmation_of :password, allow_blank: true
  end
end
# called from app/models/user.rb:3
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:154</summary>

##### ActiveModel::Validations::ClassMethods.validate

```ruby
def validate(*args, &block)
  options = args.extract_options!

  if args.all? { |arg| arg.is_a?(Symbol) }
    options.each_key do |k|
      unless VALID_OPTIONS_FOR_VALIDATE.include?(k)
        raise ArgumentError.new("Unknown key: #{k.inspect}. Valid keys are: #{VALID_OPTIONS_FOR_VALIDATE.map(&:inspect).join(', ')}. Perhaps you meant to call `validates` instead of `validate`?")
      end
    end
  end

  if options.key?(:on)
    options = options.dup
    options[:on] = Array(options[:on])
    options[:if] = Array(options[:if])
    options[:if].unshift ->(o) {
      !(options[:on] & Array(o.validation_context)).empty?
    }
  end

  set_callback(:validate, *args, options, &block)
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/secure_password.rb:75
```
</details>
<details open>
<summary>vendor/bundle/gems/activerecord-5.2.3/lib/active_record/validations/length.rb:19</summary>

##### ActiveRecord::Validations::ClassMethods.validates_length_of

```ruby
def validates_length_of(*attr_names)
  validates_with LengthValidator, _merge_attributes(attr_names)
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/secure_password.rb:79
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/helper_methods.rb:7</summary>

##### ActiveModel::Validations::HelperMethods._merge_attributes

```ruby
def _merge_attributes(attr_names)
  options = attr_names.extract_options!.symbolize_keys
  attr_names.flatten!
  options[:attributes] = attr_names
  options
end
# called from vendor/bundle/gems/activerecord-5.2.3/lib/active_record/validations/length.rb:20
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/with.rb:81</summary>

##### ActiveModel::Validations::ClassMethods.validates_with

```ruby
def validates_with(*args, &block)
  options = args.extract_options!
  options[:class] = self

  args.each do |klass|
    validator = klass.new(options, &block)

    if validator.respond_to?(:attributes) && !validator.attributes.empty?
      validator.attributes.each do |attribute|
        _validators[attribute.to_sym] << validator
      end
    else
      _validators[nil] << validator
    end

    validate(validator, options)
  end
end
# called from vendor/bundle/gems/activerecord-5.2.3/lib/active_record/validations/length.rb:20
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/length.rb:11</summary>

##### ActiveModel::Validations::LengthValidator#initialize

```ruby
def initialize(options)
  if range = (options.delete(:in) || options.delete(:within))
    raise ArgumentError, ":in and :within must be a Range" unless range.is_a?(Range)
    options[:minimum], options[:maximum] = range.min, range.max
  end

  if options[:allow_blank] == false && options[:minimum].nil? && options[:is].nil?
    options[:minimum] = 1
  end

  super
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/with.rb:86
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:138</summary>

##### ActiveModel::Validations::LengthValidator#initialize

```ruby
def initialize(options)
  if range = (options.delete(:in) || options.delete(:within))
    raise ArgumentError, ":in and :within must be a Range" unless range.is_a?(Range)
    options[:minimum], options[:maximum] = range.min, range.max
  end

  if options[:allow_blank] == false && options[:minimum].nil? && options[:is].nil?
    options[:minimum] = 1
  end

  super
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/length.rb:21
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:108</summary>

##### ActiveModel::Validations::LengthValidator#initialize

```ruby
def initialize(options)
  if range = (options.delete(:in) || options.delete(:within))
    raise ArgumentError, ":in and :within must be a Range" unless range.is_a?(Range)
    options[:minimum], options[:maximum] = range.min, range.max
  end

  if options[:allow_blank] == false && options[:minimum].nil? && options[:is].nil?
    options[:minimum] = 1
  end

  super
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:141
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/length.rb:24</summary>

##### ActiveModel::Validations::LengthValidator#check_validity!

```ruby
def check_validity!
  keys = CHECKS.keys & options.keys

  if keys.empty?
    raise ArgumentError, "Range unspecified. Specify the :in, :within, :maximum, :minimum, or :is option."
  end

  keys.each do |key|
    value = options[key]

    unless (value.is_a?(Integer) && value >= 0) || value == Float::INFINITY || value.is_a?(Symbol) || value.is_a?(Proc)
      raise ArgumentError, ":#{key} must be a nonnegative Integer, Infinity, Symbol, or Proc"
    end
  end
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:142
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:154</summary>

##### ActiveModel::Validations::ClassMethods.validate

```ruby
def validate(*args, &block)
  options = args.extract_options!

  if args.all? { |arg| arg.is_a?(Symbol) }
    options.each_key do |k|
      unless VALID_OPTIONS_FOR_VALIDATE.include?(k)
        raise ArgumentError.new("Unknown key: #{k.inspect}. Valid keys are: #{VALID_OPTIONS_FOR_VALIDATE.map(&:inspect).join(', ')}. Perhaps you meant to call `validates` instead of `validate`?")
      end
    end
  end

  if options.key?(:on)
    options = options.dup
    options[:on] = Array(options[:on])
    options[:if] = Array(options[:if])
    options[:if].unshift ->(o) {
      !(options[:on] & Array(o.validation_context)).empty?
    }
  end

  set_callback(:validate, *args, options, &block)
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/with.rb:96
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/confirmation.rb:75</summary>

##### ActiveModel::Validations::HelperMethods.validates_confirmation_of

```ruby
def validates_confirmation_of(*attr_names)
  validates_with ConfirmationValidator, _merge_attributes(attr_names)
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/secure_password.rb:80
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/helper_methods.rb:7</summary>

##### ActiveModel::Validations::HelperMethods._merge_attributes

```ruby
def _merge_attributes(attr_names)
  options = attr_names.extract_options!.symbolize_keys
  attr_names.flatten!
  options[:attributes] = attr_names
  options
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/confirmation.rb:76
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/with.rb:81</summary>

##### ActiveModel::Validations::ClassMethods.validates_with

```ruby
def validates_with(*args, &block)
  options = args.extract_options!
  options[:class] = self

  args.each do |klass|
    validator = klass.new(options, &block)

    if validator.respond_to?(:attributes) && !validator.attributes.empty?
      validator.attributes.each do |attribute|
        _validators[attribute.to_sym] << validator
      end
    else
      _validators[nil] << validator
    end

    validate(validator, options)
  end
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/confirmation.rb:76
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/confirmation.rb:6</summary>

##### ActiveModel::Validations::ConfirmationValidator#initialize

```ruby
def initialize(options)
  super({ case_sensitive: true }.merge!(options))
  setup!(options[:class])
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/with.rb:86
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:138</summary>

##### ActiveModel::Validations::ConfirmationValidator#initialize

```ruby
def initialize(options)
  super({ case_sensitive: true }.merge!(options))
  setup!(options[:class])
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/confirmation.rb:7
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:108</summary>

##### ActiveModel::Validations::ConfirmationValidator#initialize

```ruby
def initialize(options)
  super({ case_sensitive: true }.merge!(options))
  setup!(options[:class])
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:141
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:165</summary>

##### ActiveModel::EachValidator#check_validity!

```ruby
def check_validity!
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validator.rb:142
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/confirmation.rb:21</summary>

##### ActiveModel::Validations::ConfirmationValidator#setup!

```ruby
def setup!(klass)
  klass.send(:attr_reader, *attributes.map do |attribute|
    :"#{attribute}_confirmation" unless klass.method_defined?(:"#{attribute}_confirmation")
  end.compact)

  klass.send(:attr_writer, *attributes.map do |attribute|
    :"#{attribute}_confirmation" unless klass.method_defined?(:"#{attribute}_confirmation=")
  end.compact)
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/confirmation.rb:8
```
</details>
<details open>
<summary>vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations.rb:154</summary>

##### ActiveModel::Validations::ClassMethods.validate

```ruby
def validate(*args, &block)
  options = args.extract_options!

  if args.all? { |arg| arg.is_a?(Symbol) }
    options.each_key do |k|
      unless VALID_OPTIONS_FOR_VALIDATE.include?(k)
        raise ArgumentError.new("Unknown key: #{k.inspect}. Valid keys are: #{VALID_OPTIONS_FOR_VALIDATE.map(&:inspect).join(', ')}. Perhaps you meant to call `validates` instead of `validate`?")
      end
    end
  end

  if options.key?(:on)
    options = options.dup
    options[:on] = Array(options[:on])
    options[:if] = Array(options[:if])
    options[:if].unshift ->(o) {
      !(options[:on] & Array(o.validation_context)).empty?
    }
  end

  set_callback(:validate, *args, options, &block)
end
# called from vendor/bundle/gems/activemodel-5.2.3/lib/active_model/validations/with.rb:96
```
</details>
