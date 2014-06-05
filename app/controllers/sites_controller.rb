class SitesController < ApplicationController
	def index
		@sites = Site.all
	end

    def show
        @site = Site.find(params[:id])
        @nodes = @site.nodes.includes(:readings)
        @nodereadings = @nodes.map(&:readings).flatten

        @readings = Kaminari.paginate_array(@nodereadings).page(params[:page]).per(30)

        @graph_data = [ #'soil1', 'soil2', 'soil3', 'temp'].map{|s|
            {name: 'Soil 1', data: @readings.map{|r| [ r[:created_at], BigDecimal.new(r[:soil1])]}},
            {name: 'Soil 2', data: @readings.map{|r| [ r[:created_at], BigDecimal.new(r[:soil2])]}},
            {name: 'Soil 3', data: @readings.map{|r| [ r[:created_at], BigDecimal.new(r[:soil3])]}},
        ]
        
        respond_to do |format|
            format.html
        end
    end
end
