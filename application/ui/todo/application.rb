module ToDo
  class Application < Gtk::Application
    def initialize
      super 'com.iridakos.gtk-todo', Gio::ApplicationFlags::FLAGS_NONE

      signal_connect :activate do |application|
        window = Gtk::ApplicationWindow.new(application)
        window.set_title 'Hello GTK+Ruby!'
        window.present
      end
    end
  end
end
