module Todo
  class ItemListBoxRow < Gtk::ListBoxRow
    type_register

    class << self
      def init
        set_template resource: '/com/iridakos/gtk-todo/ui/todo_item_list_box_row.ui'
      end
    end

    def initialize(item)
      super()
    end
  end
end
