# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{keyword_ranking}
  s.version = "1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Luis Alberto Velasco"]
  s.date = %q{2010-08-17}
  s.description = %q{Create keyword rankings from the 3 major browsers}
  s.email = %q{whizkas@hotmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "LICENSE", "README", "lib/keyword_ranking.rb"]
  s.files = ["CHANGELOG", "Gemfile", "Gemfile.lock", "LICENSE", "README", "Rakefile", "lib/keyword_ranking.rb", "spec/keyword_ranking_spec.rb", "spec/spec.opts", "Manifest", "keyword_ranking.gemspec"]
  s.homepage = %q{http://github.com/whizkas/keyword_ranking}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Keyword_ranking", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{keyword_ranking}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Create keyword rankings from Google, Yahoo and Bing}

  s.add_dependency "nokogiri"
  s.add_development_dependency "bundler"

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
