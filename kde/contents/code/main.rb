# <Copyright and license information goes here.>
require 'rubygems'
require 'plasma_applet'
require 'suse_gallery_wrapper'
 
module SuseGalleryPlasmoid
  class Main < PlasmaScripting::Applet
    def initialize parent
      super parent
      @testdrive_icon = package.filePath("images", "action-testdrive.png")
      @gallery = SuseGalleryWrapper.new
    end
 
    def init
      self.has_configuration_interface = false
      self.aspect_ratio_mode = Plasma::Square
      self.background_hints = Plasma::Applet.DefaultBackground
      
      layout = Qt::GraphicsLinearLayout.new Qt::Vertical, self
      @gallery.appliances.each do |appliance_id, appliance_name|
        line_layout = Qt::GraphicsLinearLayout.new(Qt::Horizontal, layout)
        label = Plasma::Label.new
        label.text = appliance_name
          
        button = Plasma::PushButton.new
        #button.text = "Push me!"
        button.setStyleSheet("width: 15px")
        button.image = @testdrive_icon
        button.setMinimumSize 24,24
        button.setMaximumSize 24,24
        button.connect(SIGNAL(:clicked)) do
          @gallery.start_testdrive appliance_id
        end

        line_layout.add_item label
        line_layout.add_item button
        
        layout.add_item line_layout
      end
      self.layout = layout
    end
  end
end
