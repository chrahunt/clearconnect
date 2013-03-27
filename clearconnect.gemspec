Gem::Specification.new do |s|
  s.name = 'clearconnect'
  s.version = '0.0.1'
  s.date = '2013-03-26'
  s.summary = 'ClearConnect API Interface for Ruby'
  s.description = ''
  s.authors = ["Christopher Hunt"]
  s.email = 'chrahunt@gmail.com'
  s.files = Dir["{lib}/**/*.rb", "LICENSE", "*.md"]
  s.homepage = ''

  s.add_dependency 'httparty', '~> 0.10'
  s.add_dependency 'savon', '~> 2.1.0'
  s.add_dependency 'xml-simple', '~> 1.1.2'
end