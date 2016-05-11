class DashboardController < ApplicationController
  skip_before_action :authenticate_user!, only: [:check_on_time]

  include Common
  def index
    @art = Artical.last

    @plan = Plan.where(user_id:current_user.id).order(:created_at).first
    ##出差天数
    @errand_count = current_user.errands.this_year.map { |e| (e.end_at - e.start_at).to_f+1 }.reduce(:+) || 0
    @start_date = Lunar.last_spring_festival
    @end_date = Lunar.next_spring_festival

  end

  def weather
    @config = YAML.load_file("config/weather.yml")["code"]
    @response = YahooWeather::Client.new.fetch(12712492)
    if @response
      code = @response.condition.code
      ap @icon = @config[code.to_i]['icon']
      render json: {icon: @icon, hint: @response.condition.text, num:f_to_c(@response.condition.temp)}
    else
      render json: {}
    end
  end

  def setting
    @user = current_user
  end

  def update_setting
    respond_to do |format|
      if current_user.update(user_params)
        format.html {redirect_to settings_path, notice:"更新个人信息成功"}
      else
        format.html {redirect_to settings_path, notice:"更新个人信息失败"}
      end
    end
  end

  def check_on_time
    # this should not check more than once a day
    # user device token to avoid check by another people
    ap Time.now
    @user = User.find_by_username(params[:username])
    if @user
      @check = {
        status: 200,
        info: "welcome"
      }
    else
      @check = {
        status: 200,
        info: "who"
      }
    end

    respond_to do |format|
      format.json { render json: @check, status: 200 }
    end
  end

  def send_to_all
    @article = Artical.find(params[:aid])
    @article.send_to_all
    respond_to do |format|
      format.js {}
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :nickname,
                                 :password,:avatar,:birthday,
                                 :realname,:gender)
  end

  def f_to_c (f)
    "#{((f.to_i - 36) / 1.8).round}℃"
  end
end
