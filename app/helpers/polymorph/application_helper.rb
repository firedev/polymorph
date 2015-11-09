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
  end
end
