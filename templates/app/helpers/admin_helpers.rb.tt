Admin.helpers do
  
  def tick_widget(input = nil)
    if input.blank?
      '<img src="/admin/newimg/notick.png" />'
    else
      '<img src="/admin/newimg/tick.png" />'
    end
  end

  def admin_position_widget(model = nil)
    if model.respond_to? :position
      html = ''
        if model.position.blank?
          if model.class.maximum(:position).nil?
            model.position = 1
            model.save
            html = "<a href=\"/admin/#{model.class.table_name}/move/top/#{model.id.to_s}\" title=\"Top\"><img src=\"/admin/img/arrow_top_dis.gif\"></a>            <a href=\"/admin/#{model.class.table_name}/move/up/#{model.id.to_s}\" title=\"Up\"> <img src=\"/admin/img/arrow_up_dis.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/down/#{model.id.to_s}\" title=\"Down\"><img src=\"/admin/img/arrow_down.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/bottom/#{model.id.to_s}\" title=\"Bottom\">              <img src=\"/admin/img/arrow_bottom.gif\">            </a>"
            return html
          else
            model.position = model.class.maximum(:position) + 1
            model.save
            html = "<a href=\"/admin/#{model.class.table_name}/move/top/#{model.id.to_s}\" title=\"Top\"><img src=\"/admin/img/arrow_top.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/up/#{model.id.to_s}\" title=\"Up\"> <img src=\"/admin/img/arrow_up.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/down/#{model.id.to_s}\" title=\"Down\"><img src=\"/admin/img/arrow_down.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/bottom/#{model.id.to_s}\" title=\"Bottom\"><img src=\"/admin/img/arrow_bottom.gif\"></a>"          
            return html
          end
        end
  
        if model.first?
          html = "<a href=\"/admin/#{model.class.table_name}/move/top/#{model.id.to_s}\" title=\"Top\"><img src=\"/admin/img/arrow_top_dis.gif\"></a>            <a href=\"/admin/#{model.class.table_name}/move/up/#{model.id.to_s}\" title=\"Up\"> <img src=\"/admin/img/arrow_up_dis.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/down/#{model.id.to_s}\" title=\"Down\"><img src=\"/admin/img/arrow_down.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/bottom/#{model.id.to_s}\" title=\"Bottom\">              <img src=\"/admin/img/arrow_bottom.gif\">            </a>"
        elsif model.last?
          html = "<a href=\"/admin/#{model.class.table_name}/move/top/#{model.id.to_s}\" title=\"Top\"><img src=\"/admin/img/arrow_top.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/up/#{model.id.to_s}\" title=\"Up\"> <img src=\"/admin/img/arrow_up.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/down/#{model.id.to_s}\" title=\"Down\"><img src=\"/admin/img/arrow_down_dis.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/bottom/#{model.id.to_s}\" title=\"Bottom\"><img src=\"/admin/img/arrow_bottom_dis.gif\"></a>"
        else
          html = "<a href=\"/admin/#{model.class.table_name}/move/top/#{model.id.to_s}\" title=\"Top\"><img src=\"/admin/img/arrow_top.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/up/#{model.id.to_s}\" title=\"Up\"> <img src=\"/admin/img/arrow_up.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/down/#{model.id.to_s}\" title=\"Down\"><img src=\"/admin/img/arrow_down.gif\"></a><a href=\"/admin/#{model.class.table_name}/move/bottom/#{model.id.to_s}\" title=\"Bottom\"><img src=\"/admin/img/arrow_bottom.gif\"></a>"          
        end

      return html
    end
  end

end
