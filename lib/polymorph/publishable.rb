module Polymorph
  module Publishable
    extend ActiveSupport::Concern

    included do
      scope :published, -> { where.not(published_at: nil) }
      scope :unpublished, -> { order("IF(#{table_name}.published_at IS NULL, 1, 0) ASC") }
    end

    def published?
      published_at
    end

    def published=(published)
      self.published_at = published ? Time.current : nil
    end
  end
end
