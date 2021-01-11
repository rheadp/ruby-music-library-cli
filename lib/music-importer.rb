class MusicImporter
    attr_reader :path
    def initialize(path)
        @path = path
    end

    def files
        Dir.entries(@path).select{|file| file['.mp3']}
    end

    def import 
        files.each {|filename| Song.create_from_filename(filename)}
    end
end
