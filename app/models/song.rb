class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :release_year, presence: true, if: :released?
  validate :date_happened?
  validate :same_title_and_year?
  # validates :artist_name, presence: true

  def released?
    self.released == true
  end

  def date_happened?
    if self.release_year
      if self.release_year > Date.today.year
        errors.add(:release_year, message: "date must be in past")
      end
    end
  end

  def same_title_and_year?
    Song.all.each do |song|
      if song.title == self.title && song.artist_name == self.artist_name && song.release_year == self.release_year
        errors.add(:title, message: "artist cannot release the same song twice in a year")
      end
    end
  end

end
