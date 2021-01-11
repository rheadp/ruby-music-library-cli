class MusicLibraryController
    def initialize(path='./db/mp3s')
      music_importer = MusicImporter.new(path)
      music_importer.import
    end
  
    def greeting
      [
        "Welcome to your music library!", 
        "To list all of your songs, enter 'list songs'.",
        "To list all of the artists in your library, enter 'list artists'.",
        "To list all of the genres in your library, enter 'list genres'.",
        "To list all of the songs by a particular artist, enter 'list artist'.",
        "To list all of the songs of a particular genre, enter 'list genre'.",
        "To play a song, enter 'play song'.",
        "To quit, type 'exit'.",
        "What would you like to do?"
      ]
    end
  
    def call
      greeting.each{|text| puts text}
      user_input = nil
      until user_input == 'exit'
        user_input = gets.chomp
        case user_input
        when 'list songs'; list_songs
        when 'list artists'; list_artists
        when 'list genres'; list_genres
        when 'list artist'; list_songs_by_artist
        when 'list genre'; list_songs_by_genre
        when 'play song'; play_song
        end
      end
    end
  
    def list_songs
      get_sorted(Song).each_with_index {|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end
  
    def get_sorted(class_instance)
      class_instance.all.sort { |a, b| a.name <=> b.name }
    end
  
    def list_artists
      get_sorted(Artist).each_with_index {|artist, index| puts "#{index+1}. #{artist.name}"}
    end
  
    def list_genres
      get_sorted(Genre).each_with_index {|genre, index| puts "#{index+1}. #{genre.name}"}
    end
  
    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      artist_name = gets.chomp
      artist = Artist.all.find {|artist| artist.name == artist_name}
      if artist
        artist.songs.sort { |a, b| a.name <=> b.name }
        .each_with_index{|song, index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
      end
    end
  
    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      genre_name = gets.chomp
      genre = Genre.all.find {|genre| genre.name == genre_name}
      if genre
        genre.songs.sort { |a, b| a.name <=> b.name }
        .each_with_index{|song, index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
      end
    end
  
    def play_song
      puts "Which song number would you like to play?"
      song_number = gets.chomp.to_i
      songs = get_sorted(Song)
      if song_number.between?(1,songs.length)
        song = songs[song_number - 1]
        puts "Playing #{song.name} by #{song.artist.name}"  
      end
    end
  end