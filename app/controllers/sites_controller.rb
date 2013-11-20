class SitesController < ApplicationController
    def show
        @site = Site.find(params[:id])
        @collection_points = @site.collection_points
        @soilmoistures = []

        @collection_points.each_with_index do |point, key|
            @soilmoistures[key] = Hash.new
            @soilmoistures[key]['pointName'] = point.name
            @soilmoistures[key]['soilMoistureData'] = []

            point.soilmoistures.each do |soil|
                @soilmoistures[key]['soilMoistureData'] << soil
            end
        end


        respond_to do |format|
            format.html
            format.json { render :json => @soilmoistures.to_json }
        end
    end
end
