require 'fakeweb'

require 'suse_gallery_wrapper'

FIXTURES = 'fixtures/'

BASE_URL        = 'susestudio.com'
BASIC_AUTH_USER = 'xvuetrkt'
BASIC_AUTH_PASS = 'tsrjU6VPhcE6'

FakeWeb.allow_net_connect = false

describe SuseGalleryWrapper do

  before :all do
    FakeWeb.register_uri(:get,
                         "http://#{BASIC_AUTH_USER}:#{BASIC_AUTH_PASS}@#{BASE_URL}/api/v2/gallery/appliances_list/?popular=''&per_page=5",
                         :body => File.read("%s/popular_5.xml" % FIXTURES))
    @gallery = SuseGalleryWrapper.new
  end

  describe "#get_logo" do
    it "returns an the location to the appliance id" do
      GalleryRequest.stub(:system) {:foo}

      @gallery.get_logo(3).should == "/tmp/3"
    end
  end
end
