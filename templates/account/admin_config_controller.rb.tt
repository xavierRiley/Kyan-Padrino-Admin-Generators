Admin.controllers :admin_configuration do

  get :contains, :map => 'admin_configuration/contains/*splat',  do
    # /admin/admin_configuration/contains/modelName/containerName/any/fields/here/for/contents
    modelName = params[:splat].shift.to_s.split('_').each {|word| word.capitalize}.join('')
    containerName = params[:splat].shift
    contentNames = params[:splat]
    
    @config = AdminConfiguration.where({:model_name => modelName, :fieldset => containerName}).first
    logger.write(contentNames);
    @config.contains= contentNames
    
    if @config.save!
      return "Changes saved"
    else
      return "There was an error whilst saving changes"
    end
  end
  
  get :config, :with => :model_name do
    @modelConfig = AdminConfiguration.where({:model_name => params[:model_name]})
    return @modelConfig.to_json
  end

end