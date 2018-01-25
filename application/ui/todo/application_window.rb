module Todo
  class ApplicationWindow < Gtk::ApplicationWindow
    # Register the class in the GLib world
    type_register

    class << self
      def init
        # Set the template from the resources binary
        set_template resource: '/com/iridakos/gtk-todo/ui/application_window.ui'

        bind_template_child 'add_new_item_button'
        bind_template_child 'todo_items_list_box'
      end
    end

    def initialize(application)
      super application: application

      set_title 'GTK+ Simple ToDo'

      add_new_item_button.signal_connect 'clicked' do |button|
        new_item_window = NewItemWindow.new(application, Todo::Item.new(user_data_path: application.user_data_path))
        new_item_window.present
      end

      load_todo_items
    end

    def load_todo_items
      todo_items_list_box.children.each { |child| todo_items_list_box.remove child }

      json_files = Dir[File.join(File.expand_path(application.user_data_path), '*.json')]
      items = json_files.map{ |filename| Todo::Item.new(filename: filename) }

      items.each do |item|
        todo_items_list_box.add Todo::ItemListBoxRow.new(item)
      end
    end
  end
end
