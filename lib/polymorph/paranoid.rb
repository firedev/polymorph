module Polymorph
  module Paranoid
    extend ActiveSupport::Concern

    included do
      default_scope -> { where(deleted_at: nil) }
    end

    def deleted?
      deleted_at
    end

    def paranoid?
      true
    end

    def paranoid_destroy
      return if respond_to?(:before_paranoid_destroy) && before_paranoid_destroy == false
      update!(deleted_at: Time.current)
    end

    module ClassMethods
      def restore(id)
        unscoped.update(id, deleted_at: nil)
      end
    end
  end
end
