module Polymorph
  class OrderableController < Polymorph::ApplicationController
    def create
      klass.reorder(order)
      head :ok
    end

    private

    def klass
      @klass = params[:orderable_type].constantize
    end

    def order
      params[klass.table_name.singularize]
    end
  end
end
