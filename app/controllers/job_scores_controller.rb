class JobScoresController < ApplicationController
  before_action :set_job_score, only: [:show, :destroy]

  # GET /job_scores
  # GET /job_scores.json
  def index
    @job_scores = JobScore.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /job_scores/1
  # GET /job_scores/1.json
  def show
  end


  # DELETE /job_scores/1
  # DELETE /job_scores/1.json
  def destroy
    @job_score.destroy
    respond_to do |format|
      format.html { redirect_to job_scores_url, notice: 'Job score was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_score
      @job_score = JobScore.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_score_params
      params.require(:job_score).permit(:job, :start_time, :end_time, :status)
    end
end
