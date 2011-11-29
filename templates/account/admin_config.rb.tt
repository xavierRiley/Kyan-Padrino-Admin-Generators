# Admin config setup for all models

confirmation     = shell.ask "This will regenerate the admin configurations for all models. Are you sure? (y|n)"

shell.say ""

if confirmation == 'y'
  AdminConfiguration.delete_all()
  Dir["models/*.rb"].each do |file_path|
    require Padrino.root(file_path) # Make sure that the model has been loaded.

    basename  = File.basename(file_path, File.extname(file_path))
    clazz     = basename.camelize.constantize
    shell.say clazz.name
    clazz.columns.each {|col| tempconf = AdminConfiguration.new({:model_name => clazz.name, :fieldset => col.name, :contains => [col.name], :hide => false, :label => '', :validation => []}); tempconf.save! }  

  end
end

shell.say "All done"
