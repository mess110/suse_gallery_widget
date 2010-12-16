require 'rubygems'
require 'logger'
require 'suse_gallery_wrapper'

log = Logger.new(STDOUT)
log.level = Logger::DEBUG

log.debug "contacting suse studio gallery"
wrapper = SuseGalleryWrapper.new
log.debug "Number of popular appliances: #{wrapper.appliances.size}"
log.debug "Appliance logo: #{wrapper.get_logo(238737)}"
log.debug "Starting a public testdrive"
log.debug "Public testdrive response: #{wrapper.start_testdrive(wrapper.appliances.keys[0])}"
