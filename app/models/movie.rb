class Movie < ActiveRecord::Base
  
  def self.all_ratings()
    return ['G', 'PG', 'PG-13', 'R']
  end

  def self.with_ratings(ratings_list)
    if ratings_list.nil?
      return movies
    else
      return movies.where(rating: ratings_list)
    end
  end
end
