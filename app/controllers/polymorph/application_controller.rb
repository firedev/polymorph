module Polymorph
  class ApplicationController < ::ApplicationController
    before_action :authorize_polymorph

    private

    def authorize_polymorph
      Polymorph.configuration.authorize.call(self) if Polymorph.configuration.authorize
    end
  end
end
