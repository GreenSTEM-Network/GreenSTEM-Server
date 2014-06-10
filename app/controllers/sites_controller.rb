require 'csv'

class SitesController < ApplicationController
	def index
		@sites = Site.all
	end

    def show
        start_date = Date.parse(params[:start_date]) rescue nil
        end_date = Date.parse(params[:end_date]) rescue nil

        @site = Site.find(params[:id])
        @nodes = @site.nodes.includes(:readings)
        @nodereadings = @nodes.map(&:readings).flatten

        if !start_date.nil?
            @nodereadings.delete_if {|r| r[:created_at].to_date < start_date}
        end

        if !end_date.nil?
            @nodereadings.delete_if {|r| r[:created_at].to_date > end_date}
        end

        @nodereadings = @nodereadings.sort_by(&:created_at).reverse

        @readings = Kaminari.paginate_array(@nodereadings).page(params[:page]).per(30)

        @graph_data = [
            {name: 'Soil 1', data: @readings.map{|r| [ r[:created_at], BigDecimal.new(r[:soil1])]}},
            {name: 'Soil 2', data: @readings.map{|r| [ r[:created_at], BigDecimal.new(r[:soil2])]}},
            {name: 'Soil 3', data: @readings.map{|r| [ r[:created_at], BigDecimal.new(r[:soil3])]}},
        ]
        
        respond_to do |format|
            format.html
            format.csv {
                csv = CSV.generate do |csv|
                    #header
                    csv << ['CreatedAt', 'NodeId', 'Soil1', 'Soil2', 'Soil3', 'Temp']
                    #data
                    @nodereadings.each do |r|
                        csv << [ r[:created_at].localtime.strftime("%m/%d/%Y %I:%M %p"), r[:node_id], r[:soil1], r[:soil2], r[:soil3], r[:temp] ]
                    end
                end
                send_data csv
            }
        end
    end
end
