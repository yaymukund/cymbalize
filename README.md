cymbalize
=========

Use symbols in ActiveRecord columns. This gem is more or less a rewrite of
[nofxx's symbolize gem][nofxx_symbolize]. It implements the same interface,
but without `allow_nil`.

### Installation

Include the gem in your Gemfile:

```
gem 'cymbalize', '~> 0.1.0'
```

### Features

Please note that `:scopes`, `:methods`, and `:allow_blank` don't do
anything unless `:in` is an array with at least one symbol.

#### Symbolize a column with `symbolize`

```ruby
class User < ActiveRecord::Base
  symbolize :gender
end

u = User.new(:gender => :robot)
u.gender # :robot
```

#### Add a list of valid values with `:in`

```ruby
class User < ActiveRecord::Base
  symbolize :gender, :in => [:decepticon, :autobot]
end

u = User.new(:gender => :autobot)
u.valid? # true
u.gender = :robot
u.valid? # false
```

#### Add boolean methods with `:methods`

```ruby
class User < ActiveRecord::Base
  symbolize :gender, :in => [:asterix, :obelix], :methods => true
end

u = User.new(:gender => :asterix)
u.asterix? # true
u.obelix? # false
```

#### Add ActiveRecord scopes with `:scopes`

```ruby
class User < ActiveRecord::Base
  symbolize :gender, :in => [:zerg, :protoss, :terran], :scopes => true
end

u = User.create(:gender => :zerg)
User.zerg.include?(u) # true
User.protoss.include?(u) # false
```

#### Allow blank values with `:allow_blank`

```ruby
class User < ActiveRecord::Base
  symbolize :gender, :in => [:mod, :rocker], :allow_blank => true
end

u = User.new(:gender => nil)
u.valid? # true
u.gender # nil

u.gender = ''
u.valid? # true
u.gender # nil
```

[nofxx_symbolize]: https://github.com/nofxx/symbolize
