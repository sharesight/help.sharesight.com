class Minitest::Test
  private

  def root_path
    @root_path ||= File.expand_path(File.dirname(__FILE__) + "/../..")
  end

  def list(path)
    Dir.entries(root_path + '/' + path)
  end

  def read(file_path)
    File.read(root_path + '/' + file_path)
  end

end
