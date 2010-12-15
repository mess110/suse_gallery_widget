require 'net/http'
require 'nokogiri'
require 'singleton'

class GalleryRequest
  BASE_URL        = 'susestudio.com'
  BASIC_AUTH_USER = 'xvuetrkt'
  BASIC_AUTH_PASS = 'tsrjU6VPhcE6'

  def self.get_request path
    Net::HTTP.start(BASE_URL) {|http|
      req = Net::HTTP::Get.new(path)
      req.basic_auth BASIC_AUTH_USER, BASIC_AUTH_PASS
      parse_xml(http.request(req).body)
    }
  end
  
  def self.post_request path
    Net::HTTP.start(BASE_URL) {|http|
      req = Net::HTTP::Post.new(path)
      req.basic_auth BASIC_AUTH_USER, BASIC_AUTH_PASS
      parse_xml(http.request(req).body)
    }
  end

  def self.parse_xml xml
    Nokogiri::XML(xml)
  end
end

class SuseGalleryWrapper

  attr_reader :appliances

  def initialize
    @appliances = request_appliances
  end

  def start_testdrive appliance_id
    #TODO make sure its in range!

    appliance_version = get_version(appliance_id)

    parsed_xml = GalleryRequest.post_request("/api/v2/gallery/appliance_testdrive/#{appliance_id}?version=#{appliance_version}")
    {
      :host     => parsed_xml.xpath('//host').text,
      :port     => parsed_xml.xpath('//port').text,
      :password => parsed_xml.xpath('//password').text
    }
  end

  private

  def request_appliances
    parsed_xml = GalleryRequest.get_request('/api/v2/gallery/appliances_list/?popular=''&per_page=5')
    appliances = []
    parsed_xml.xpath('//appliance').each do |a|
      appliances << {
        a.xpath('./id').text => a.xpath('./name').text
      }
    end
    appliances
  end

  def get_version appliance_id
    parsed_xml = GalleryRequest.get_request("/api/v2/gallery/appliances/#{appliance_id}")
    parsed_xml.xpath('.//appliance//version').text
  end
end
