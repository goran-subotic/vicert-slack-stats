class JobScoresController < ApplicationController
  before_action :set_job_score, only: [:show, :edit, :update, :destroy]

  # GET /job_scores
  # GET /job_scores.json
  def index
    #@job_scores = JobScore.all
    @job_scores = JobScore.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /job_scores/1
  # GET /job_scores/1.json
  def show
  end

  # GET /job_scores/new
  def new
    @job_score = JobScore.new
  end

  # GET /job_scores/1/edit
  def edit
  end

  # POST /job_scores
  # POST /job_scores.json
  def create
    @job_score = JobScore.new(job_score_params)

    respond_to do |format|
      if @job_score.save
        format.html { redirect_to @job_score, notice: 'Job score was successfully created.' }
        format.json { render :show, status: :created, location: @job_score }
      else
        format.html { render :new }
        format.json { render json: @job_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_scores/1
  # PATCH/PUT /job_scores/1.json
  def update
    respond_to do |format|
      if @job_score.update(job_score_params)
        format.html { redirect_to @job_score, notice: 'Job score was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_score }
      else
        format.html { render :edit }
        format.json { render json: @job_score.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:job_score).permit(:job, :start_time, :end_time)
    end
end
