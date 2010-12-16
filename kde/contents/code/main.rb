# <Copyright and license information goes here.>
require 'rubygems'
require 'korundum4'
require 'plasma_applet'
require 'suse_gallery_wrapper'
 
module SuseGalleryPlasmoid
  class Main < PlasmaScripting::Applet
    def initialize parent
      super parent
      @testdrive_icon = package.filePath("images", "action-testdrive.png")
      Thread.abort_on_exception = true
    end
 
    def init
      self.has_configuration_interface = false
      self.aspect_ratio_mode = Plasma::Square
      self.background_hints = Plasma::Applet.DefaultBackground

      @layout = Qt::GraphicsLinearLayout.new Qt::Vertical, self

      @busy_widget = Plasma::BusyWidget.new
      @busy_widget.label = "Fetching popular appliances"
      @layout.add_item @busy_widget
      
      self.layout = layout

      refresh
    end

    private

    def refresh
      #Thread.new {
        puts "starting to fetch"
        #@layout.add_item @busy_widget
        
        @gallery = SuseGalleryWrapper.new
        #@layout.remove_item @busy_widget
        puts "fetch done"
        @busy_widget.set_visible false
        
        @gallery.appliances.each do |appliance_id, appliance_name|
          line_layout = Qt::GraphicsLinearLayout.new(Qt::Horizontal, layout)
          label = Plasma::Label.new
          label.text = appliance_name
          
          button = Plasma::PushButton.new
          #button.text = "Push me!"
          button.image = @testdrive_icon
          button.setMinimumSize 24,24
          button.setMaximumSize 24,24
          button.connect(SIGNAL(:clicked)) do
            Thread.new {
              begin
                puts "starting testdrive #{appliance_id}"
                td = @gallery.start_testdrive(appliance_id)
                puts td.inspect
                @gallery.connect_to_testdrive(td)
              rescue
                KDE::MessageBox.error(Qt::Widget.new, $!,
                                      "Testdrive error")
              end
            }
          end

          line_layout.add_item label
          line_layout.add_item button
          
          @layout.add_item line_layout
        end
      #}
   end

  end
end
