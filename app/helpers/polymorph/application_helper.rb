module Polymorph
  module ApplicationHelper
    def polymorph_destroy_path(resource)
      if resource.respond_to? :paranoid?
        polymorph.paranoid_path(
          paranoid_type: resource.class.name,
          paranoid_id: resource
        )
      else
        url_for([:admin, resource]) rescue url_for(resource)
      end
    end

    def polymorph_publish_path(resource)
      if resource.respond_to? :published?
        polymorph.publish_path(
          publishable_type: resource.class.name,
          publishable_id: resource
        )
      else
        url_for([:admin, resource]) rescue url_for(resource)
      end
    end
  end
end
