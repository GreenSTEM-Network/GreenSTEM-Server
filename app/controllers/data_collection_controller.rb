class DataCollectionController < ApplicationController

    skip_before_filter :verify_authenticity_token

    def submit
        if params[:type] == 'soilmoisture'
            data = Soilmoisture.new(params[:data])
            data.save!
        end

        render :json => 'success'

    end

    private

    def format_json?
        request.format.json?
    end

end
