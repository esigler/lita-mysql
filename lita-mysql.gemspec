Gem::Specification.new do |spec|
  spec.name          = 'lita-mysql'
  spec.version       = '0.0.1'
  spec.authors       = ['Eric Sigler']
  spec.email         = ['me@esigler.com']
  spec.description   = 'A handler to show various MySQL information'
  spec.summary       = 'A handler to show various MySQL information'
  spec.homepage      = 'https://github.com/esigler/lita-mysql'
  spec.license       = 'MIT'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '>= 3.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'
end
