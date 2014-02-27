class SummaryController < ApplicationController
  def index
    @results = NodeReading
        .group('node_id')
        .order('collection_time DESC')

    @weather = WeatherLocation.all.map do |w|
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
