# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record/blockwhere/version'

Gem::Specification.new do |spec|
  spec.name          = "activerecord-blockwhere"
  spec.version       = ActiveRecord::Blockwhere::VERSION
  spec.authors       = ["yuki teraoka"]
  spec.email         = ["info@techscore.com"]
  spec.description   = %q{Simply conditions DSL for ActiveRecord }
  spec.summary       = %q{Simply conditions DSL for ActiveRecord. It helps using Arel Predications in the block.}
  spec.homepage      = "https://github.com/techscore/activerecord-blockwhere"
  spec.license       = "BSD"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "activerecord", ">= 3.0.0"
  spec.add_development_dependency "sqlite3-ruby"
  spec.add_development_dependency "database_cleaner"
  spec.add_runtime_dependency "activerecord", ">= 3.0.0"
  spec.add_runtime_dependency "arel", ">= 3.0.0"
end
