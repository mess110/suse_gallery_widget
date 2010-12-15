Gem::Specification.new do |spec|
   spec.name = 'gallery_wrapper'
   spec.version ='0.0.1'

   # this is important - it specifies which files to include in the gem.
   spec.files = [
      "lib/gallery_wrapper.rb"
   ]

   # optional, but useful to your users
   spec.summary = 'Blah at the moment'
   spec.author = 'Cristian Mircea Messel'
   spec.email = 'suse_gallery_widget@yahoo.com'
   spec.homepage = 'http://susestudio.com'
   
   spec.add_dependency('nokogiri')

   # you did document with RDoc, right?
   spec.has_rdoc = false
 end
