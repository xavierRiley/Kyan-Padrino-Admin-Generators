class KyanAdminPage < Padrino::Generators::AdminPage

  # register with Padrino
  Padrino::Generators.add_generator(:kyan_admin_page, self)
  
  # Define the source template root and themes
  def self.source_root; File.expand_path(File.dirname(__FILE__)); end
  def self.banner; "padrino-gen admin"; end
  def self.themes; Dir[File.dirname(__FILE__) + "/templates/assets/stylesheets/themes/*"].map { |t| File.basename(t) }.sort; end

  include Thor::Actions
  include Padrino::Generators::Actions
  include Padrino::Generators::Components::Actions
  
  def create_controller
    self.destination_root = options[:root]
    if in_app_root?
      models.each do |model|
        @orm = default_orm || Padrino::Admin::Generators::Orm.new(model, adapter)
        
        self.behavior = :revoke if options[:destroy]
        empty_directory destination_root("/admin/views/#{@orm.name_plural}")

        template "templates/page/controller.rb.tt",       destination_root("/admin/controllers/#{@orm.name_plural}.rb")

        #Ask about validations for everything except accounts
        if @orm.name_plural != 'accounts' and ask("Do you want to add validations now for #{@orm.name_plural} (y|n)", :no, :red) == 'y'
          @orm.column_fields.each do |model_field| 
            if ask("Is #{model_field[:name].to_s} required? (y|n)", :no, :red) == 'y'
              model_field[:required] = true
            end
          end
          template "templates/#{ext}/page/_form.#{ext}.tt", destination_root("/admin/views/#{@orm.name_plural}/_form.#{ext}")
        else
          template "templates/#{ext}/page/_form.#{ext}.tt", destination_root("/admin/views/#{@orm.name_plural}/_form.#{ext}")
        end
        template "templates/#{ext}/page/edit.#{ext}.tt",  destination_root("/admin/views/#{@orm.name_plural}/edit.#{ext}")
        template "templates/#{ext}/page/new.#{ext}.tt",   destination_root("/admin/views/#{@orm.name_plural}/new.#{ext}")

        ## Carrierwave support
        # based on naming convention of '_file' add in carrierwave support
        @orm.column_fields.each do |model_field| 
          if model_field[:name].to_s.index('_file') or model_field[:name].to_s.index('_img')
            empty_directory("public/images/uploads")
            empty_directory("public/uploads")
            prepend_file destination_root("models/#{@orm.name_singular}.rb"), "require 'carrierwave/orm/#{fetch_component_choice(:orm)}'\n"
            inject_into_file destination_root("models/#{@orm.name_singular}.rb"),"   mount_uploader :#{model_field[:name]}, Uploader\n", :before => 'end'
          end
        end

        ## Publish support
        # based on naming convention of 'publish' add in published scope
        @orm.column_fields.each do |model_field|
          if model_field[:name].to_s == 'publish'
            inject_into_class destination_root("models/#{@orm.name_singular}.rb"), @orm.name_singular.capitalize do 
              "  scope :published, lambda { where(\"publish = ?\", true).order(\"position ASC\") }\n"
            end
          end
        end

        ## Acts as list position support
        # based on naming convention of 'position' add in acts as list support
        @orm.column_fields.each do |model_field|
          if model_field[:name].to_s == 'position'
            require_dependencies('acts_as_list')
            gsub_file destination_root("/admin/controllers/#{@orm.name_plural}.rb"), "#{@orm.name_singular.capitalize}.all", "#{@orm.name_singular.capitalize}.find(:all, :order => 'position')"
            inject_into_file destination_root("models/#{@orm.name_singular}.rb"),"  validates_uniqueness_of :#{model_field[:name]}\n", :before => 'end'
            inject_into_file destination_root("models/#{@orm.name_singular}.rb"),"  acts_as_list :order => \"#{model_field[:name]}\"\n", :before => 'end'
            inject_into_file destination_root("models/#{@orm.name_singular}.rb"),"  after_create :initialize_position\n", :before => 'end'
            inject_into_file destination_root("models/#{@orm.name_singular}.rb"),"  private\n", :before => 'end'
            inject_into_file destination_root("models/#{@orm.name_singular}.rb"),"  def initialize_position\n    self.position = #{@orm.name_singular}.maximum(:#{model_field[:name]}) + 1\n  end\n", :after => "  private\n"
          end
        end

        #Leave the index page till and remove columns based on questions
        #Ask about which fields to display for everything except accounts
        if @orm.name_plural != 'accounts' and ask("Do you want to specify which columns to display for the #{@orm.name_plural} index page? (y|n)", :display_all, :red) == 'y'
          @ignoreFields = []
          @orm.columns.each do |model_field|
            if ask("Display #{model_field.name.to_s}? (y|n)", :no, :red) != 'y'
              @ignoreFields << model_field.name
            end
          end
          template "templates/#{ext}/page/index.#{ext}.tt", destination_root("/admin/views/#{@orm.name_plural}/index.#{ext}")
        else
          template "templates/#{ext}/page/index.#{ext}.tt", destination_root("/admin/views/#{@orm.name_plural}/index.#{ext}")
        end

        options[:destroy] ? remove_project_module(@orm.name_plural) : add_project_module(@orm.name_plural)
      end
    else
      say "You are not at the root of a Padrino application! (config/boot.rb not found)"
    end
  end
end
