module Todo
  class ItemListBoxRow < Gtk::ListBoxRow
    type_register

    class << self
      def init
        set_template resource: '/com/iridakos/gtk-todo/ui/todo_item_list_box_row.ui'

        bind_template_child 'details_button'
        bind_template_child 'todo_item_title_label'
        bind_template_child 'todo_item_details_revealer'
        bind_template_child 'todo_item_notes_text_view'
        bind_template_child 'delete_button'
        bind_template_child 'edit_button'
      end
    end

    def initialize(item)
      super()

      todo_item_title_label.text = item.title || ''

      todo_item_notes_text_view.buffer.text = item.notes

      details_button.signal_connect 'clicked' do
        todo_item_details_revealer.set_reveal_child !todo_item_details_revealer.reveal_child?
      end

      delete_button.signal_connect 'clicked' do
        item.delete!

        # Locate the application window
        application_window = application.windows.find { |w| w.is_a? Todo::ApplicationWindow }
        application_window.load_todo_items
      end

      edit_button.signal_connect 'clicked' do
        new_item_window = NewItemWindow.new(application, item)
        new_item_window.present
      end
    end

    def application
      parent = self.parent
      parent = parent.parent while !parent.is_a? Gtk::Window
      parent.application
    end
  end
end
