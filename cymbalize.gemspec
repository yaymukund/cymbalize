# -*- encoding: utf-8 -*-
# Add this directory to the Ruby load path.
lib_directory = File.expand_path(File.dirname(__FILE__))
unless $LOAD_PATH.include?(lib_directory)
  $LOAD_PATH.unshift(lib_directory)
end

# Now for the main event...
Gem::Specification.new do |s|
  s.name          = 'cymbalize'
  s.version       = '0.1.0'
  s.summary       = 'Use symbols in ActiveRecord columns.'
  s.description   = <<-HERE
Cymbalize is a tiny extension to support symbolized columns in ActiveRecord,
with optional convenience methods. It's heavily inspired by nofxx's symbolize
Gem.
  HERE
  s.date          = Date.today.strftime('%Y-%m-%d')
  s.authors       = ['Mukund Lakshman']
  s.email         = 'yaymukund@gmail.com'
  s.homepage      = 'http://github.com/yaymukund/cymbalize'

  s.require_paths = ['lib']

  s.files         = `git ls-files -- {lib,spec}/*`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")

  s.add_dependency 'rails', '>= 3.0.0'
  s.add_dependency 'activerecord', '>= 3.0.0'

  s.add_development_dependency 'rspec'
end
