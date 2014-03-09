class SummaryController < ApplicationController
  def index
    # todo refactor so this doesn't require two queries

    conn = ActiveRecord::Base.connection
    sql = 'SELECT ' +
      'nr.id ' +
      'FROM ' +
      'node_readings nr ' +
      'JOIN (' +
      'SELECT max("node_readings"."id") as id, ' +
      '"node_readings"."node_id" ' +
      'FROM "node_readings"  ' +
      'GROUP BY "node_readings"."node_id" ' +
      ') sub ' +
      'ON nr.id = sub.id'
    
    res = conn.execute sql

    @results = NodeReading
        .find_all_by_id(res.map { |x| x['id'] })
    
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
