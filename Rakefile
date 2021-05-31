require "bundler/setup"

APP_RAKEFILE = File.expand_path("test/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"
load "rails/tasks/statistics.rake"

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
  t.warning = false
end

task default: :test

namespace :frontend do
  task :transpile do
    `bin/transpile`
  end

  task :bundle do
    p "Bundling frontend for use in browser..."

    `yarn webpack --mode production`
    `cp dist/index.js app/assets/javascripts/action_text_syntax_highlighter.js`
    `cp dist/index.js.map app/assets/javascripts/action_text_syntax_highlighter.js.map`

    p "Done!"
  end

  task :build do
    Rake::Task["frontend:transpile"].execute
    Rake::Task["frontend:bundle"].execute
  end
end