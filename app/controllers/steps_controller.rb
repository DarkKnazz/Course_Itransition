class StepsController < ApplicationController
  before_action :set_step, only: [:edit, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :update_step, :destroy]
  skip_before_action :verify_authenticity_token
  respond_to :js, :json, :html
  # GET /steps/1/edit
  def edit
    secureEnter @step
  end

  # POST /steps
  # POST /steps.json
  def create
    @post = Post.find(params[:post_id])
    @step = Step.new(:post=>@post)
    secureEnter @step
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
    secureEnter @step
    @step.destroy
    respond_to do |format|
      format.html { redirect_to edit_post_path(@step.post.id) }
      format.json { head :no_content }
    end
  end

  def update_step
    @step = Step.find(params[:id])
    secureEnter @step
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

    def secureEnter step
      if step.post.user_id != current_user.id && current_user.isAdmin == false
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_params
      params.require(:step).permit(:post_id, :name)
    end
end
