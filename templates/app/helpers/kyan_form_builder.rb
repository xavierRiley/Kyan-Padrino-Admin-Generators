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
        $(function() {
          $('\##{@object.class.name.demodulize.underscore}_#{field}').tinymce({
            // Location of TinyMCE script
            script_url : '/admin/javascripts/tiny_mce/tiny_mce.js',

            // General options
            mode : "textareas",
            theme : "advanced",
            plugins : "pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",

            // Theme options
            theme_advanced_buttons1 : "code,|,bold,italic,underline,|,styleselect,formatselect,|,bullist,numlist",
            theme_advanced_buttons2 : "",
            theme_advanced_buttons3 : "",
            theme_advanced_buttons4 : "",
            //theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
            //theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
            //theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak",
            theme_advanced_toolbar_location : "top",
            theme_advanced_toolbar_align : "left",
            theme_advanced_statusbar_location : "bottom",
            theme_advanced_resizing : true,

            // Example content CSS (should be your site CSS)
            content_css : "/stylesheets/core.css,/admin/stylesheets/mce_override.css",

            // Drop lists for link/image/media/template dialogs
            template_external_list_url : "js/template_list.js",
            external_link_list_url : "js/link_list.js",
            external_image_list_url : "js/image_list.js",
            media_external_list_url : "js/media_list.js",

            // Replace values for the template plugin
            template_replace_values : {
                    username : "Some User",
                    staffid : "991234"
            }
          });
        });
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
        field_html << '<div class="control-group"><div class="clear">'
          field_html << '<div class="image_wrap">'
            field_html << @template.content_tag(:img, '', :width => '80', :src => @object.send(field.to_sym).admin_thumb.url, :class => 'preview clear admin_thumb')
            field_html << <<-EOF
              <script type="text/javascript">
                $('document').ready(function() {
                  $('.image_wrap .options a.delete').toggle(function(e) {
                    e.preventDefault();
                    linkButton = $(this);
                    var optionsContainer = linkButton.parent();
                    linkButton.text('Undo').removeClass('btn-danger');
                    optionsContainer.siblings('img').eq(0).css('opacity', 0.2);
                    optionsContainer.find('.remove_img').eq(0).val('1');
                    },
                    function(e) {
                    e.preventDefault();
                    linkButton = $(this);
                    var optionsContainer = linkButton.parent();
                    linkButton.text('Delete').addClass('btn-danger');
                    optionsContainer.siblings('img').eq(0).css('opacity', 1);
                    optionsContainer.find('.remove_img').eq(0).val('0');
                  });
                });
              </script>
              EOF
              field_html << '<div class="options">'
              field_html << hidden_field("remove_#{field}", :value=>'0', :class => 'remove_img')
              field_html << @template.content_tag(:a, 'Delete', :href=>'#delete', :class=>'delete image-btn btn btn-danger')
              field_html << '</div>'
            field_html << '</div>'
          field_html << '</div>'
          field_html << @template.content_tag(:h5, 'Upload Replacement')
          field_html << file_field(field, :class => css_class_options)
          field_html << '</div>'
        else
        field_html << '<div class="control-group">'
          field_html << @template.content_tag(:img, '', :width => '80', :src => @object.send(field.to_sym).url, :class => 'preview')
          field_html << @template.content_tag(:h5, 'Upload Replacement')
          field_html << file_field(field, :class => css_class_options)
          field_html << check_box("remove_#{field}")
          field_html << '</div></div>'
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
        field_html << '<div class="document_list"><ul><li>'
        field_html << @template.content_tag(:p, File.basename(@object.send(field.to_sym).path) )
        field_html << <<-EOF
          <script type="text/javascript">
            $('document').ready(function() {
              $('.document_list .document-btn.delete').toggle(function(e) {
                e.preventDefault();
                linkButton = $(this);
                linkButton.text('Undo').removeClass('btn-danger');
                linkButton.parent().eq(0).css('opacity', 0.4);
                linkButton.siblings('.remove_document').eq(0).val('1');
                },
                function(e) {
                e.preventDefault();
                linkButton = $(this);
                var optionsContainer = linkButton.parent();
                linkButton.text('Delete').addClass('btn-danger');
                linkButton.parent().eq(0).css('opacity', 1);
                linkButton.siblings('.remove_document').eq(0).val('0');
              });
            });
          </script>
          <a href="\#delete" data-method="edit" class="delete document-btn options btn btn-mini btn-danger">Delete</a>
          <a href="#{@object.send(field.to_sym).url}" class="options btn btn-mini">Download</a>
        EOF
        field_html << hidden_field("remove_#{field}", :value=>'0', :class => 'remove_document')
        field_html << '</li></ul>'
        field_html << '<br />'
        field_html << @template.content_tag(:h5, 'Upload Replacement')
        field_html << file_field(field, :class => css_class_options)
        field_html << '</div>'
      else
        field_html << @template.content_tag(:span, 'No File Uploaded' )
        field_html << '<br /><br />'
        field_html << file_field(field, :class => css_class_options)
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
