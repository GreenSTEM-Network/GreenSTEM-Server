class DataCollectionController < ApplicationController

    skip_before_filter :verify_authenticity_token

    def submit
      site = Site.find(params[:site_id])

      DataCollectionContext.new(site, params).collect!

      render :json => 'success'

    end

    private

    def format_json?
        request.format.json?
    end

end
