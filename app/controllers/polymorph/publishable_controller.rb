module Polymorph
  class PublishableController < Polymorph::ApplicationController
    def publish
      if resource.published_at?
        resource.update_column(:published_at, nil)
      else
        resource.update_column(:published_at, Time.current)
      end
    end

    private

    def klass
      @klass ||= params[:publishable_type].camelize.constantize
    end

    def resource
      @resource ||= klass.unscoped.find(params[:publishable_id])
    end
  end
end
