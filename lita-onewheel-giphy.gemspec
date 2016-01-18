Gem::Specification.new do |spec|
  spec.name          = 'lita-onewheel-giphy'
  spec.version       = '0.3.1'
  spec.authors       = ['Andrew Kreps']
  spec.email         = ['andrew.kreps@gmail.com']
  spec.description   = 'Lita chat interface to giphy api for MOAR GIFS'
  spec.summary       = 'Aims to be a complete implementation of the Giphy api.  https://github.com/giphy/GiphyAPI'
  spec.homepage      = 'https://github.com/onewheelskyward/lita-onewheel-giphy'
  spec.license       = 'MIT'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '~> 4.7'
  spec.add_runtime_dependency 'rest-client', '~> 1.6'

  spec.add_development_dependency 'bundler', '~> 1.3'
  # spec.add_development_dependency 'pry-byebug', '~> 3.3'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rack-test', '~> 0.6'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'coveralls', '~> 0.8'
end
