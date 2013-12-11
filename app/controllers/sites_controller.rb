class SitesController < ApplicationController
    def show
        @site = Site.find(params[:id])
        @nodes = @site.nodes.includes(:readings)
        @readings = Kaminari.paginate_array(@nodes.map(&:readings).flatten).page(params[:page]).per(30)

        respond_to do |format|
            format.html
        end
    end
end
