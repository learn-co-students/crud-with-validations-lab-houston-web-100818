class Song < ActiveRecord::Base
    validates :title, uniqueness: true, presence: true
    validate :release_year_check
    validates :artist_name, presence: true 
    
    def release_year_check
        if released == true && release_year == "" || released == true && release_year == nil
            errors.add(:release_year, "can't be empty.")
        elsif released == true && release_year.to_i > Time.current.year 
            errors.add(:release_year, "is invalid. Released year must be less or equal to current year.")
        end 
    end 
end
