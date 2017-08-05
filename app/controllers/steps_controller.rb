class StepsController < ApplicationController
  before_action :set_step, only: [:edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  respond_to :js, :json, :html
  # GET /steps/1/edit
  def edit
    @step.content = ""
    @step.save
  end

  # POST /steps
  # POST /steps.json
  def create
    @post = Post.find(params[:post_id])
    @step = Step.new(:post=>@post)
    @step = Step.create(step_params)
    @step.content = ""
    respond_to do |format|
      if @step.save
        format.html { redirect_to edit_post_path(@post.id), notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
    @step.destroy
    respond_to do |format|
      format.html { redirect_to edit_post_path(@step.post.id) }
      format.json { head :no_content }
    end
  end

  def update_step
    @step = Step.find(params[:id])
    @step.content = params[:data_value]
    @step.save
  end

  def sort
    params[:order].each do |key,value|
      Step.find(value[:id]).update_attribute(:position,value[:position])
    end
  end

  private

    def set_step
      @step = Step.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:post_id, :name)
    end
end
