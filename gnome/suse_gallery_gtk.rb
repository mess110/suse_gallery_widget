require 'rubygems'
require 'suse_gallery_wrapper'
require 'gtk2'

class SuseGalleryGtk
  
  attr_reader :status_icon
  attr_reader :gallery

  def initialize
    build_status_icon
    Thread.new {
      get_suse_appliances
      build_menu
    }
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
    @status_icon.blinking=true
  end

  def build_menu
    menu=Gtk::Menu.new

    @gallery.appliances.each_pair do |key, value|
      appliance_entry=Gtk::ImageMenuItem.new(value)
      appliance_entry.signal_connect('activate'){
        @status_icon.blinking=true
        Thread.new {
          puts "starting testdrive #{key}"
          td = @gallery.start_testdrive(key)
          puts td
          @status_icon.blinking=false
        }
      }
      menu.append(appliance_entry)
    end

    quit=Gtk::ImageMenuItem.new(Gtk::Stock::QUIT)
    quit.signal_connect('activate'){Gtk.main_quit}

    menu.append(Gtk::SeparatorMenuItem.new)
    menu.append(quit)
    menu.show_all

    @status_icon.signal_connect('popup-menu'){|tray, button, time| menu.popup(nil, nil, button, time)}
    @status_icon.blinking=false
  end
end

SuseGalleryGtk.new
