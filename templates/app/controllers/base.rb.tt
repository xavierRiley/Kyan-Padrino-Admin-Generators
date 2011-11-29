Admin.controllers :base do

  get :index, :map => "/" do
    render "base/index"
  end
  
  get :toggle, :map => "toggle/:model_name/:field_name/:id" do
    @currentModel = params[:model_name].singularize.camelize.constantize
    @currentModel.find(params[:id]).toggle!(params[:field_name])
    redirect "admin/" + params[:model_name]
  end

  get :position, :map => ":model_name/move/:new_pos/:id" do
    @currentModel = params[:model_name].singularize.camelize.constantize
    case params[:new_pos]
    when 'top'
      @currentModel.find(params[:id]).move_to_top
    when 'up'
      @currentModel.find(params[:id]).move_higher
    when 'down'
      @currentModel.find(params[:id]).move_lower
    when 'bottom'
      @currentModel.find(params[:id]).move_to_bottom
    end
    redirect "admin/" + params[:model_name]
  end

end
