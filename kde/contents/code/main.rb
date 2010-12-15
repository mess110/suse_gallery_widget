# <Copyright and license information goes here.>
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
      @gallery.get_appliances.each do |a|
        line = Qt::GraphicsLinearLayout.new(Qt::Horizontal, layout) do
          label = Plasma::Label.new
          label.text = a[:name]
          
          button = Plasma::PushButton.new
          button.text = "Push me!"
          button.image = @testdrive_icon
          button.connect(SIGNAL(:clicked)) do
            puts "button #{a[:id]} has been pressed"
          end

          add_item label
          add_item button
        end
        layout.add_item line
      end
      self.layout = layout
    end
  end
end
