# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eel/version'

Gem::Specification.new do |gem|
  gem.name          = 'eel'
  gem.version       = Eel::VERSION
  gem.authors       = ['Ivan Efremov', 'Anatoly Lapshin']
  gem.email         = ['st8998@gmail.com', 'holywarez@gmail.com']
  gem.description   = %q{It is more like Squeel but without Squ}
  gem.summary       = %q{It is more like Squeel but without Squ}
  gem.homepage      = 'https://github.com/StrangeMood/eel'

  gem.add_dependency 'activerecord', '~> 3.2'
  gem.add_dependency 'activesupport', '~> 3.2'

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
