
KAMINARI_PATCH = <<-KAMINARI_PATCH
class Kaminari::Helpers::SinatraHelpers::ActionViewTemplateProxy
  def render(*args)
    base = ActionView::Base.new.tap do |a|
      a.view_paths << File.expand_path(Padrino.root('app/views'), __FILE__)
      a.view_paths << File.expand_path('../../../../app/views', __FILE__)
    end
    base.render(*args)
  end
end
KAMINARI_PATCH

create_file "lib/kaminari_override", KAMINARI_PATCH
directory Padrino.root("generators/templates/erb/app/kaminari"),        destination_root("app", "views", "kaminari")
