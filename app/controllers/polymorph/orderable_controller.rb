module Polymorph
  class OrderableController < Polymorph::ApplicationController
    def create
      klass.reorder(order)
      head :ok
    end

    private

    def orderable
      params[:orderable_type]
    end

    def klass
      orderable.camelize.constantize
    end

    def order
      params[orderable]
    end
  end
end
