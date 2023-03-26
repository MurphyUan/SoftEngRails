class Movie < ActiveRecord::Base
  
  @@return_movies = nil

  def self.all_ratings()
    ['G', 'PG', 'PG-13', 'R']
  end

  def self.with_ratings(ratings_list)
    unless ratings_list.nil?
      @@return_movies = movies.where(rating: ratings_list)
    end
    self
  end

  def self.with_order(order_list)
    unless order_list.nil?
      @@return_movies = movies.order()
    end
    self
  end

  def self.movies
    if @@return_movies.nil?
      movies
    else 
      @@return_movies
    end
  end
end
