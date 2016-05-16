module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /^the home\s?page$/
      '/'
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    when /^the edit page for "(.+)"$/
      mov = Movie.find_by_title($1)
      edit_movie_path(mov)
    when /^the details page for "(.+)"$/
      movie_path(Movie.find_by_title($1))
    when /^the Similar Movies page for "(.+)"$/
      same_director_movie_path(Movie.find_by_title($1))
    when /^the Rotten Potatoes home page$/
      '/movies'
    when /^(.*)'s profile page$/i
      user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
