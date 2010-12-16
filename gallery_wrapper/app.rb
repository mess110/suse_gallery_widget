require 'rubygems'
require 'suse_gallery_wrapper'

wrapper = SuseGalleryWrapper.new
puts wrapper.appliances.size
puts wrapper.get_logo(238737)
puts wrapper.start_testdrive(wrapper.appliances.keys[0])
