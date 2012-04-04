module Kernel

  def require_dirs(dirs)
    Array.wrap(dirs).each do |load_path|
      Dir.glob("#{load_path}/**/*.rb").each do |file|
        require file
      end
    end
  end
  
end
