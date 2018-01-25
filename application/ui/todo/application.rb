module ToDo
  class Application < Gtk::Application
    attr_reader :user_data_path

    def initialize
      super 'com.iridakos.gtk-todo', Gio::ApplicationFlags::FLAGS_NONE

      @user_data_path = File.expand_path('~/.gtk-todo-tutorial')
      unless File.directory?(@user_data_path)
        puts "First run. Creating user's application path: #{@user_data_path}"
        FileUtils.mkdir_p(@user_data_path)
      end

      signal_connect :activate do |application|
        window = Todo::ApplicationWindow.new(application)
        window.present
      end
    end
  end
end
