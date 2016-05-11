class Artical < ActiveRecord::Base
  belongs_to :user
  validates :title, :content, :user_id, presence: true

  paginates_per 6

  def send_to_all
    access_token = File.open("public/token","rb") do |file|
      JSON.parse(file.read)["access_token"]
    end

    content = {
      "filter" =>{
        "is_to_all" => true
      },
      "mpnews" => {
        "media_id" => get_media_id
      },
      "msgtype" => "mpnews"
    }

    url = URI.parse("https://api.weixin.qq.com/cgi-bin/message/mass/sendall")
    send_req = Net::HTTP::Post.new(url+"?access_token=#{access_token}", initheader = {'Content-Type' =>'application/json'})
    send_req.body = content.to_json
    send_res = Net::HTTP.start(url.host,url.port, use_ssl:true) do |http|
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request send_req
    end

    ap send_res.body
  end

  def get_media_id
    access_token = File.open("public/token","rb") do |file|
      JSON.parse(file.read)["access_token"]
    end

    config = YAML.load_file('config/wechat.yml')
    @wechat = Wechat::Api.new(
      config["default"]["appid"],
      config["default"]["secret"],
      config["default"]["access_token"],
    false)

    media_id=""

    File.open('public/logo.jpg') do |f|
      media_id = @wechat.media_create('image',f)["media_id"]
    end

    data = {
      "articles" =>[{"thumb_media_id" => media_id,
                     "author" => "#{self.user.try :realname}",
                     "title"=> "#{self.title}",
                     "content_source_url" => "http://jarvis.eurus.cn",
                     "content" => "#{self.content}",
                     "digest" => "digest",
                     "show_cover_pic" => "1"}]
    }

    upload_url = URI.parse("https://api.weixin.qq.com/cgi-bin/media/uploadnews?access_token=#{access_token}")
    req = Net::HTTP::Post.new(upload_url.path+"?access_token=#{access_token}",
                              initheader = {'Content-Type' =>'application/json'})
    req.body = data.to_json

    res = Net::HTTP.start(upload_url.host, upload_url.port, use_ssl:true) do |http|
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.ssl_version = :SSLv3
      http.request req
    end

    send_media_id = JSON.parse(res.body)["media_id"]
  end


end
