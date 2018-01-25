module Todo
  class ItemListBoxRow < Gtk::ListBoxRow
    type_register

    class << self
      def init
        set_template resource: '/org/iridakos/gtk-todo/ui/todo_item_list_box_row.ui'
      end
    end

    def initialize(application)
      super application: application
    end
  end
end
