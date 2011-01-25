lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'mad_mimi/version'

Gem::Specification.new do |s|
  s.name        = 'mad_mimi'
  s.version     = MadMimi::VERSION

  s.authors     = "Ozéias Sant'ana"
  s.email       = 'oz.santana@gmail.com'
  s.homepage    = 'http://railsbox.org'

  s.summary     = %q{Manage your MadMimi audience}

  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if s.respond_to? :required_rubygems_version=

  s.add_runtime_dependency 'faraday',     '0.5.4'

  s.add_dependency 'faraday_middleware',  '0.3.1'
  s.add_dependency 'multi_xml',           '0.2.0'

  s.add_development_dependency 'rspec',   '~> 2.4.0'
  s.add_development_dependency 'webmock', '~> 1.6.2'

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths      = ['lib']
end