require 'rubygems'
require 'suse_gallery_wrapper'

wrapper = SuseGalleryWrapper.new
puts wrapper.start_testdrive(2)
