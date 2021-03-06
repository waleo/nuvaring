require File.expand_path("../lib/nuvaring_calendar/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'nuvaring'
  s.version     = NuvaringCalendar::VERSION
  s.date        = '2015-04-13'
  s.summary     = "Nuvaring Planning Calendar"
  s.description = "Provides insertion and removal dates for nuvaring birth control."
  s.authors     = ["Wale Olaleye"]
  s.homepage    = 'https://github.com/waleo/nuvaring'
  s.license     = 'MIT'
  s.files       =  Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]  

  s.add_development_dependency "minitest", "~> 5.5"
end
