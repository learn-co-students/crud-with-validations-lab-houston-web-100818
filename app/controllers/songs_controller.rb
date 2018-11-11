class SongsController < ApplicationController
    before_action :define_current_song

    def define_current_song
        if params[:id]
            @song = Song.find(params[:id])
        else 
            @song = Song.new
        end 
    end 
    
    def song_params
        params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
    end 

    def update 
        @song.assign_attributes(song_params)
        if @song.valid?
            @song.save 
            redirect_to song_path(@song)
        else 
            render :edit
        end 
    end 

    def destroy 
        @song.destroy
        redirect_to songs_path
    end 

    def create 
        @song = Song.new(song_params)
        if @song.valid?
            @song.save 
            redirect_to song_path(@song)
        else 
            render :new
        end 
    end 
    
    def index 
        @songs = Song.all
    end 

end
