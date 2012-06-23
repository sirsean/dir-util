module DirUtil
    VERSION = "0.1"

    def self.to_all_files
        nil
    end

    def self.subdirectories(source_path)
        source = Dir.new(File.expand_path(source_path))
        dirs = source.entries.select{|x| x[0] != "." }.map{|x| File.absolute_path(x, source.path) }.select{|x| File.directory?(x)}
        (dirs + dirs.map{|dir| subdirectories(Dir.new(dir))}).flatten
    end

    def self.to_all_files(source_path, &block)
        source = Dir.new(File.expand_path(source_path))
        source.entries.
            select{|x| x[0]!="."}.
            map{|x| File.absolute_path(x, source.path)}.each do |file|
            if File.file?(file)
                block.call file
            elsif File.directory?(file)
                to_all_files(Dir.new(file), &block)
            end
        end
    end
end
