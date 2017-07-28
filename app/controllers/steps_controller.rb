class StepsController < ApplicationController
  before_action :set_step, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  respond_to :js, :json, :html
  # GET /steps/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
  end
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = Step.create(step_params)
    @post = Post.find(step_params[:post_id])
    respond_to do |format|
      if @step.save
        format.html { redirect_to @post, notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @step.content = params[:data_value]
    @step.save
    respond_to do |format|
      if @step
        format.html { redirect_to edit_step_path(@step.id) }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to steps_url, notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def clear
    @step = Step.find(4)
    @step.content = params[:data_value].split("\"")[1]
    @step.save
    respond_to do |format|
      if @step
        format.html { redirect_to edit_step_path(@step.id) }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_Link_From_Video
      link = step_params[:video].split("v=")[1]
    end

    def set_step
      @step = Step.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:post_id, :name, :text, :image, :video)
    end
end
