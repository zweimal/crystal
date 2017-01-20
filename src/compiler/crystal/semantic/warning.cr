class Crystal::Program
  record Warning, name : String, desc : String, filename : String, line_number : Int32, column_number : Int32
  alias Warnings = Set(Warning)

  property warnings = Warnings.new

  def warn(name, desc, filename, line_number, column_number)
    filename = File.expand_path(filename)
    warning = Warning.new(name, desc, filename, line_number, column_number)
    unless warnings.includes?(warning)
      warnings << warning
      stderr.puts "#{"warning: ".colorize.yellow} #{desc} '#{name}' is unused"
      stderr.puts "  #{Crystal.relative_filename(filename)}:#{line_number}"
      stderr.puts
    end
  end
end
