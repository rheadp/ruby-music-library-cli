class Artist
    extend Concerns::Findable
    attr_accessor :name, :songs

    @@all = []
    def initialize(name)
        @name = name
        @songs = []
    end
    def save
        @@all << self
    end
    def self.create(name)
        artist = self.new(name) #initializes the artist
        artist.save
        artist
    end
    def add_song(song)
        song.artist = self unless song.artist #using unless to make sure there are no duplicates
        @songs << song unless @songs.include?(song) #adds the song to the current artist song's without adding duplicates
    end
    def genres
        @songs.map(&:genre).uniq
    end
    def self.all
        @@all
    end
    def self.destroy_all
        @@all.clear
    end

end
