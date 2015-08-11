class StatController < ApplicationController

  def index
    #@stats = Stat.all

    per_page = params[:per_page] ? params[:per_page]:10

    @stats_all_time = Stat.paginate(:page => params[:page], :per_page => per_page).order("msg_count DESC")

    #@stats_all_time = Stat.order("msg_count DESC").first(10)

  end
  
  def show
    if(params[:id] == 'all')


      @stat = Stat.all
      
      respond_to do |format|
        format.html { redirect_to action: :index }
        format.xml {render :xml => @stat}
        format.json  {render :json => @stat.as_json}
      end
    else
      redirect_to action: :index
    end
  end

end
