class Padrino::Helpers::FormBuilder::KyanFormBuilder < Padrino::Helpers::FormBuilder::AbstractFormBuilder

  def select_block(field, options={}, label_options={})
      label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
      options[:class] = prepare_class_options(options[:class], ['select', field.to_s])
      field_html = label(field, label_options)
      field_html << error_message_on(field)
      field_html << select(field, options)
      @template.content_tag(:div, field_html)
  end

  # def check_boxes_block(field, options={}, label_options={})
  #     label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
  #     options[:class] = prepare_class_options(options[:class], ['check_box', field.to_s])
  #     field_html = label(field, label_options)
  #     field_html << error_message_on(field)
  #     field_html << check_box(field, options)
  #     @template.content_tag(:div, field_html, :class => 'group')
  # end
  
  def gallery_block(field, options={}, label_options={})
    #required options
    # upload_field_name
    # image_models
    # image_class
      label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
      options[:class] = prepare_class_options(options[:class], ['thumbnail_gallery', field.to_s])
      field_html = label(field, label_options)
      field_html << error_message_on(field)
      image_list_html = ''
      options[:image_models].each do |image_model|
        if image_model.send(options[:upload_field_name].to_sym).class.to_s == 'Uploader' and not image_model.send(options[:upload_field_name].to_sym).url.nil?
          if image_model.send(options[:upload_field_name].to_sym).versions.include? :admin_thumb
            image_option = ''
            image_option << @template.content_tag(:img, '', :width => '80', :src => image_model.send(options[:upload_field_name].to_sym).admin_thumb.url, :class => 'preview admin_thumb')
            modal_options = ''
            modal_options << @template.content_tag(:a, 'Edit', :'data-target' => '#',:'data-method' => 'edit', :href => @template.url(image_model.class.to_s.pluralize.underscore.to_sym, :edit, :id => image_model.id) + '?layout=false', :'data-toggle' => 'modal', :rel => 'nofollow', :'data-exclude' => '.form_send,#machine_id_fieldset', :class => 'btn edit', :title => image_model.caption)
            modal_options << @template.content_tag(:a, 'Delete', :href => @template.url(image_model.class.to_s.pluralize.underscore.to_sym, :destroy, :id => image_model.id) + '?layout=false', :class => 'btn btn-danger', :'data-toggle' => 'modal')
            modal_options = @template.content_tag(:div, modal_options, :class => 'options')
            item_wrap = ''
            item_wrap = @template.content_tag(:div, image_option + "\n" + modal_options, :class => 'item_wrap')
            image_list_html << @template.content_tag(:li, item_wrap)
          end #end test for Uploader
        end
      end
      image_list_html << <<-ADD_IMAGE
		<li class="add_new">
			<div class="item_wrap">
				<a class="btn create" rel="nofollow" data-target="\#" data-toggle="modal" href="#{@template.url(options[:image_class].to_s.pluralize.underscore.to_sym, :new)}" data-method="edit" data-exclude=".form_send">Create new</a>
			</div>
		</li>
      ADD_IMAGE
      field_html << @template.content_tag(:ul, image_list_html)
      @template.content_tag(:fieldset, field_html, :class => 'thumbnail_gallery')
  end

  def documents_block(field, options={}, label_options={})
    label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
    options[:class] = prepare_class_options(options[:class], ['thumbnail_gallery', field.to_s])
    field_html = label(field, label_options)
    field_html << error_message_on(field)
    document_list_html = ''
    options[:document_models].each do |document_model|
      if document_model.send(options[:upload_field_name].to_sym).class.to_s == 'Uploader' and not document_model.send(options[:upload_field_name].to_sym).url.nil?
        document_option = ''
        document_option << @template.content_tag(:p, document_model.send(options[:upload_field_name].to_sym).url, :class => 'document')
        modal_options = ''
        modal_options << @template.content_tag(:a, 'Edit', :'data-method' => 'edit', :href => '#myModal_a', :'data-toggle' => 'modal', :rel => 'nofollow', :class => 'btn btn-mini')
        modal_options << @template.content_tag(:a, 'Delete', :href => '#deleteLink', :class => 'btn btn-mini btn-danger')
        modal_options = @template.content_tag(:div, modal_options, :class => 'options')
        item_wrap = ''
        item_wrap = @template.content_tag(:div, document_option + "\n" + modal_options, :class => 'item_wrap')
        modal_window = ''
        modal_window << <<-MODAL
    <div class="modal hide fade" id="myModal_a">
      <div class="modal-header">
        <a class="close" data-dismiss="modal">x</a>
        <h3>Edit photo</h3>
      </div>
      <div class="modal-body">
        <label>Caption</label>
        <input type="text"/>
      </div>
      <div class="modal-footer">
        <a href="#" class="btn btn-success" data-dismiss="modal" >Save</a>
        <a href="#" class="btn" data-dismiss="modal">Close</a>
      </div>
    </div>
    MODAL
        document_list_html << @template.content_tag(:li, item_wrap + "\n" + modal_window)
      end
    end
    document_list_html << <<-ADD_DOCUMENT
<li class="add_new">
  <div class="item_wrap">
    <a class="btn" rel="nofollow" data-toggle="modal" href="#myModal_a" data-method="edit">Create new</a>
  </div>
  <div class="modal hide fade" id="create_new">
    <div class="modal-header">
      <a class="close" data-dismiss="modal">x</a>
      <h3>Edit photo</h3>
    </div>
    <div class="modal-body">
      <label>Caption</label>
      <input type="text"/>
      
    </div>
    <div class="modal-footer">
      <a href="#" class="btn btn-success" data-dismiss="modal" >Save</a>
      <a href="#" class="btn" data-dismiss="modal">Close</a>
    </div>
  </div>
</li>
    ADD_DOCUMENT
    document_list_html = @template.content_tag(:ul, document_list_html)
    field_html << @template.content_tag(:div, document_list_html, :class => 'document_list')
    @template.content_tag(:fieldset, field_html)
  end

  def boolean_block(field, options={}, label_options={})
      label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
      options[:class] = prepare_class_options(options[:class], ['check_box', field.to_s])
      field_html = label(field, label_options)
      field_html << error_message_on(field)
      field_html << check_box(field, options)
      @template.content_tag(:div, field_html, :class => 'group')
  end

  def text_mce_block(field, options={}, label_options={})
      label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
      css_class_options = prepare_class_options(options[:class], ['text_area', field.to_s])
      field_html = label(field, label_options)
      field_html << error_message_on(field)
      field_html << <<-EOF
        <script type="text/javascript">
          window.onload = function() {
          var oFCKeditor = new FCKeditor('#{@object.class.name.demodulize.underscore}_#{field}');
          oFCKeditor.BasePath = "/admin/javascripts/fckeditor/";
          oFCKeditor.ReplaceTextarea();
          }
        </script>
      EOF
      field_html << text_area(field.to_sym, :class => css_class_options)
      @template.content_tag(:div, field_html)
  end

  def image_upload_block(field, options={}, label_options={})
      label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
      css_class_options = prepare_class_options(options[:class], ['upload', field])
      field_html = label(field, label_options)
      field_html << error_message_on(field)

      if @object.send(field.to_sym).class.to_s == 'Uploader' and not @object.send(field.to_sym).url.nil?
        if @object.send(field.to_sym).versions.include? :admin_thumb
        field_html << '<div class="control-group">'
          field_html << @template.content_tag(:img, '', :width => '80', :src => @object.send(field.to_sym).admin_thumb.url, :class => 'preview clear admin_thumb')
          field_html << @template.content_tag(:h5, 'Upload Replacement')
          field_html << file_field(field, :class => css_class_options)
          field_html << '<label class="checkbox">'
          field_html << check_box("remove_#{field}")
          field_html << @template.content_tag(:span, 'Remove Image?')
          field_html << '</label>'
          field_html << '</div>'
        else
        field_html << '<div class="control-group">'
          field_html << @template.content_tag(:img, '', :width => '80', :src => @object.send(field.to_sym).url, :class => 'preview')
          field_html << @template.content_tag(:h5, 'Upload Replacement')
          field_html << file_field(field, :class => css_class_options)
          field_html << check_box("remove_#{field}")
          field_html << '</div>'
        end
      else
        field_html << file_field(field, :class => css_class_options)
      end
      @template.content_tag(:div, field_html)
  end

  def file_upload_block(field, options={}, label_options={})
      label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
      css_class_options = prepare_class_options(options[:class], ['upload', field])

      field_html = label(field, label_options)
      field_html << error_message_on(field)

      if @object.send(field.to_sym).class.to_s == 'Uploader' and not @object.send(field.to_sym).url.nil?
        field_html << '<div class="control-group">'
        field_html << @template.content_tag(:img, '', :width => '80', :src => '/admin/newimg/report.png', :class => 'preview')
        field_html << @template.content_tag(:span, @object.send(field.to_sym).path )
        field_html << @template.content_tag(:h5, 'Upload Replacement')
        field_html << file_field(field, :class => css_class_options)
        field_html << check_box("remove_#{field}")
        field_html << '</div>'
      else
        field_html << '<div class="control-group">'
        field_html << @template.content_tag(:img, '', :width => '80', :src => '/admin/newimg/report.png', :class => 'preview')
        field_html << @template.content_tag(:h5, 'No File Uploaded' )
        field_html << file_field(field, :class => css_class_options)
        field_html << '</div>'
      end

      @template.content_tag(:div, field_html)
  end

  def date_block(field, options={}, label_options={})
      label_options.reverse_merge!(:caption => options.delete(:caption)) if options[:caption]
      css_class_options = prepare_class_options(options[:class], ['date', field])
      now = Date.today
      selected = options[:selected] ||= now
      options[:years_to_now] ||= 100
      options[:years_from_now] ||= 0

      year_from = now.year - options[:years_to_now]
      year_to = now.year + options[:years_from_now]

      field_html = label(field, label_options)
      field_html << error_message_on(field)
      field_html << <<-EOF
        <script type="text/javascript">
          $('document').ready(function() {
            $('.date_selector select').change(function() {
              $('input.#{field}').val($('##{field}_year').val() + '-' + $('##{field}_month').val() + '-' + $('##{field}_day').val());
            });
          });
        </script>
      EOF
      field_html << '<div class="date_selector">'
      field_html <<  @template.select_tag("#{field}_day".to_sym, :id=>"#{field}_day", :options => (1..31).map{|n| "%02d" % n}, :selected => ("%02d" % selected.day).to_s)
      field_html <<  @template.select_tag("#{field}_month".to_sym, :id=>"#{field}_month", :options => (1..12).map{|n| [Date::MONTHNAMES[n], "%02d" % n]}, :selected => ("%02d" % selected.month).to_s)
      field_html <<  @template.select_tag("#{field}_year".to_sym, :id=>"#{field}_year", :options => (year_from..year_to).to_a.reverse!, :selected => ("%02d" % selected.year).to_s)
      field_html <<  hidden_field(field.to_sym, :class => css_class_options, :value => (selected.strftime('%Y-%m-%d')) )
      field_html << '</div>'
      @template.content_tag(:div, field_html)
  end

  private

  def prepare_class_options(input_class=nil, defaults=[])
    css_class_options = []
    case input_class.class.to_s
    when 'String'
      css_class_options << input_class
    when 'Array'
      css_class_options += input_class
    end

    case defaults.class.to_s
    when 'String'
      css_class_options << defaults
    when 'Array'
      css_class_options += defaults
    end

    return css_class_options.join(" ")
  end

end
