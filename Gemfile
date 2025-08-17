source "https://rubygems.org"

gem "github-pages", "~> 232", group: :jekyll_plugins

# Add jekyll-config to enable `jekyll config` command
gem "jekyll-config", "~> 0.1"

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.1", :platforms => [:mingw, :x64_mingw, :mswin]
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]

group :test do
  gem "html-proofer", "~> 5.0"
end
