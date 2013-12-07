class SitesController < ApplicationController
    def show
        @site = Site.find(params[:id])
        @nodes = @site.nodes
        @data = @nodes.node_readings

        respond_to do |format|
            format.html
        end
    end
end
