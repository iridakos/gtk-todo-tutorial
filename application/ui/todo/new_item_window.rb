module Todo
  class NewItemWindow < Gtk::Window
    # Register the class in the GLib world
    type_register

    class << self
      def init
        # Set the template from the resources binary
        set_template resource: '/com/iridakos/gtk-todo/ui/new_item_window.ui'

        # Bind the window's widgets
        bind_template_child 'id_value_label'
        bind_template_child 'title_text_entry'
        bind_template_child 'notes_text_view'
        bind_template_child 'priority_combo_box'
        bind_template_child 'cancel_button'
        bind_template_child 'save_button'
      end
    end

    def initialize(application, item)
      super application: application

      set_title "ToDo item #{item.id} - #{item.is_new? ? 'Create' : 'Edit' } Mode"

      id_value_label.text = item.id
      title_text_entry.text = item.title if item.title
      notes_text_view.buffer.text = item.notes if item.notes

      # Configure the combo box
      model = Gtk::ListStore.new(String)
      Todo::Item::PRIORITIES.each do |priority|
        iterator = model.append
        iterator[0] = priority
      end

      priority_combo_box.model = model
      renderer = Gtk::CellRendererText.new
      priority_combo_box.pack_start(renderer, true)
      priority_combo_box.set_attributes(renderer, "text" => 0)
    end
  end
end
