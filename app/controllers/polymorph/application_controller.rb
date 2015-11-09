module Polymorph
  class ApplicationController < ::ApplicationController
    before_action :authorize_polymorph

    private

    def authorize_polymorph
      if !Polymorph.configuration.authorize
        flash[:error] = 'Missing Polymorph Authorize'
        redirect_to :root_path
      else
        Polymorph.configuration.authorize.call(self)
      end
    end
  end
end
