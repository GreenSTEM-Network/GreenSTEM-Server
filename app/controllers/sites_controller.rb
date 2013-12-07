class SitesController < ApplicationController
    def show
        @site = Site.find(params[:id])
        @nodes = @site.nodes.includes(:readings)
        @readings = @nodes.map(&:readings).flatten

        respond_to do |format|
            format.html
        end
    end
end
