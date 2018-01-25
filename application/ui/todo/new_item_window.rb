module Todo
  class NewItemWindow < Gtk::Window
    # Register the class in the GLib world
    type_register

    class << self
      def init
        # Set the template from the resources binary
        set_template resource: '/com/iridakos/gtk-todo/ui/new_item_window.ui'
      end
    end

    def initialize(application)
      super application: application
    end
  end
end
