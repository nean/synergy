class TimelogsController < ApplicationController
  authorize_resource
  before_action :set_timelog, only: [:show, :edit, :update, :destroy]

  # GET /timelogs
  # GET /timelogs.json
  def index
    @timelogs = Timelog.all
  end

  # GET /timelogs/1
  # GET /timelogs/1.json
  def show
  end

  # GET /timelogs/new
  def new
    @timelog = Timelog.new
  end

  # GET /timelogs/1/edit
  def edit
  end

  # POST /timelogs
  # POST /timelogs.json
  def create
    @owner = find_parent
    @timelog = Timelog.new(timelog_params)
    @timelog.owner = @owner
    @timelog.user_id = current_user.id
    respond_to do |format|
      if @timelog.save
        format.html { redirect_to @timelog, notice: 'Timelog was successfully created.' }
        format.json { render :show, status: :created, location: @timelog }
      else
        format.html { render :new }
        format.json { render json: @timelog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timelogs/1
  # PATCH/PUT /timelogs/1.json
  def update
    respond_to do |format|
      if @timelog.update(timelog_params)
        format.html { redirect_to @timelog, notice: 'Timelog was successfully updated.' }
        format.json { render :show, status: :ok, location: @timelog }
      else
        format.html { render :edit }
        format.json { render json: @timelog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timelogs/1
  # DELETE /timelogs/1.json
  def destroy
    @timelog.destroy
    respond_to do |format|
      format.html { redirect_to timelogs_url, notice: 'Timelog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timelog
      @timelog = Timelog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timelog_params
      params[:timelog]
    end

    def find_parent
      case  params[:timelog][:owner_type]
        when 'Project' 
          return Project.find params[:timelog][:owner_id]
        when 'Task' 
          return Task.find params[:timelog][:owner_id]
      end
    end
end
