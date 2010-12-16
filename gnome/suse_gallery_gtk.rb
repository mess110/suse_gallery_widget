require 'rubygems'
require 'suse_gallery_wrapper'
require 'gtk2'

class SuseGalleryGtk
  
  attr_reader :status_icon
  attr_reader :gallery

  def initialize
    build_status_icon
    get_suse_appliances
    build_menu
    Gtk.main
  end
  
  private

  def get_suse_appliances
    @gallery = SuseGalleryWrapper.new
  end

  def build_status_icon
    @status_icon=Gtk::StatusIcon.new
    @status_icon.pixbuf=Gdk::Pixbuf.new('favicon.ico')
    @status_icon.tooltip='SuseGallery'
    @status_icon.signal_connect('activate'){ puts "a lot of info here"}
  end

  def build_menu
    menu=Gtk::Menu.new

    count = 0
    @gallery.appliances.each do |a|
      appliance_entry=Gtk::ImageMenuItem.new(a[:name])
      appliance_entry.signal_connect('activate'){
        puts "starting testdrive #{a[:id]}"
        td = @gallery.start_testdrive(2)
        puts td[:host]
        puts td[:port]
        puts td[:password]
      }
      menu.append(appliance_entry)
    end

    quit=Gtk::ImageMenuItem.new(Gtk::Stock::QUIT)
    quit.signal_connect('activate'){Gtk.main_quit}

    menu.append(Gtk::SeparatorMenuItem.new)
    menu.append(quit)
    menu.show_all

    @status_icon.signal_connect('popup-menu'){|tray, button, time| menu.popup(nil, nil, button, time)}
  end
end

SuseGalleryGtk.new
