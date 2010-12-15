require 'rubygems'
require 'gallery_wrapper'

appliances = SuseGalleryWrapper.get_appliances
id = appliances[2][:id]
version = SuseGalleryWrapper.get_version(id)
puts SuseGalleryWrapper.start_testdrive(id, version)
