class ArticalsController < ApplicationController
  before_action :set_artical, only: [:show, :edit, :update, :destroy]
  before_action :uptoken, only: [:new, :edit]
  # GET /articals
  # GET /articals.json
  def index
    @articals = Artical.all.order(created_at: :desc).page params[:page]
  end

  # GET /articals/1
  # GET /articals/1.json
  def show
  end

  # GET /articals/new
  def new
    @artical = Artical.new
  end

  # GET /articals/1/edit
  def edit
  end

  # POST /articals
  # POST /articals.json
  def create
    @artical = Artical.new(artical_params)
    @artical.user_id = current_user.id
    respond_to do |format|
      if @artical.save
        format.html { redirect_to @artical, notice: 'Artical was successfully created.' }
        format.json { render :show, status: :created, location: @artical }
      else
        format.html { render :new }
        format.json { render json: @artical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articals/1
  # PATCH/PUT /articals/1.json
  def update
    respond_to do |format|
      if @artical.update(artical_params)
        format.html { redirect_to @artical, notice: 'Artical was successfully updated.' }
        format.json { render :show, status: :ok, location: @artical }
      else
        format.html { render :edit }
        format.json { render json: @artical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articals/1
  # DELETE /articals/1.json
  def destroy
    @artical.destroy
    respond_to do |format|
      format.html { redirect_to articals_url, notice: 'Artical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_artical
    @artical = Artical.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def artical_params
    params.require(:artical).permit(:title, :content, :user_id, :origin)
  end
  
  def uptoken
    put_policy = Qiniu::Auth::PutPolicy.new("jarvis")
    @uptoken = Qiniu::Auth.generate_uptoken(put_policy)
  end

end
