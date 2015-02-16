namespace :docs do
  desc "Generate the annotated source code document."
  task :annotated do
    system 'groc **/*.rb **/*.js **/*.js.coffee README.md -o docs/annotated_source'
  end
end
