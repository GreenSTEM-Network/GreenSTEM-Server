class SummaryController < ApplicationController
  def index
    @results = NodeReading
        .group('node_id')
        .order('collection_time DESC')

    @weather = WeatherLocation.all.map do |w|
        #TODO Should probably cache this response: http://stackoverflow.com/questions/11308101/ruby-on-rails-how-to-cache-the-result-of-a-response-of-an-api-service
        ForecastIO.forecast(w.lat, w.lon)
    end

    json_results = {:readings => @results, :weather => @weather}

    respond_to do |format|
      format.html { render json: json_results}

      if params[:callback]
        format.js { render :json => json_results, :callback => params[:callback] }
      else
        format.json { render json: json_results}
      end
    end
  end
end
