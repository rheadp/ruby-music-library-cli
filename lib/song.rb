class Song

    attr_accessor :name
    attr_reader :artist, :genre
    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist #invokes the #artist= method instead of simply assinging to an @artist instance variable to ensure that associations are created upon initialization
        self.genre = genre if genre
end
    def save #saves the song instance to the @@all class variable
        @@all << self 
    end 

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.all #returns the class variable @@all
        @@all
    end

    def self.destroy_all #resets the @@all class variable to an empty array
        @@all.clear
    end

    def self.find_by_name(name)
        all.find do |song|
            song.name == name
        end
    end
    
    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)     #returns (does not recreate) an existing song with the provided name if one exists in @@all
                                               #invokes .find_by_name instead of re-coding the same functionality
                                                #creates a song if an existing match is not found
                                                #invokes .create instead of re-coding the same functionality
    end
    
    def self.new_from_filename(filename)
        filename.slice!('.mp3')
        artist, song, genre = filename.split(' - ')
        artist = Artist.find_or_create_by_name(artist)
        genre = Genre.find_or_create_by_name(genre)
        new(song, artist, genre)
      end
      
      def self.create_from_filename(filename)
        song = new_from_filename(filename)
        song.save
      end


end
