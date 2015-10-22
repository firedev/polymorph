module Polymorph
  module Orderable
    extend ActiveSupport::Concern

    included do
      scope :ordered, -> { order position: :asc }
      before_save :set_max_position
    end

    def set_max_position
      self.position = self.class.maximum(:position).to_i + 10 unless position
    end

    module ClassMethods
      def reorder(*new_order)
        def ensure_resource(id_or_resource)
          return id_or_resource if id_or_resource.is_a? self
          find(id_or_resource)
        end

        new_order.flatten.compact.map.each_with_index do |id_or_resource, index|
          resource = ensure_resource(id_or_resource)
          position = index * 10 + 10
          resource.update_attribute(:position, position)
          [resource, position]
        end
      end
    end
  end
end
