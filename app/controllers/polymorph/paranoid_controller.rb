module Polymorph
  class ParanoidController < Polymorph::ApplicationController
    def destroy
      if resource.deleted?
        klass.restore(resource.id)
      else
        resource.paranoid_destroy
      end
      @resource.reload
    end

    private

    def klass
      @klass ||= params[:paranoid_type].camelize.constantize
    end

    def resource
      @resource ||= klass.unscoped.find(params[:paranoid_id])
    end
  end
end
