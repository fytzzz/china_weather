# ChinaWeather
require 'open-uri'
require 'active_record'
#中国天气www.weather.com.cn
#http://m.weather.com.cn/data/101110101.html（六天预报）
#http://www.weather.com.cn/data/sk/101110101.html（实时天气信息）
class Region < ActiveRecord::Base
  #默认城市
  def self.get_default_region
    self.find_by_num('101280601')
  end

  #天气信息
  def get_weather_info
    return [get_weatherinfo, get_real_time_weatherinfo]
  rescue Exception => ex
    ex.message
  end

  #实时天气信息
  def get_real_time_weatherinfo
    parse_xml(open("http://www.weather.com.cn/data/sk/#{self.num}.html").read)["weatherinfo"] rescue {}
  end

  #六天预报
  def get_weatherinfo
    parse_xml(open("http://m.weather.com.cn/data/#{self.num}.html").read)["weatherinfo"] rescue {}
  end

  private
  def parse_xml(data)
    ActiveSupport::JSON.decode(data)
  end
end