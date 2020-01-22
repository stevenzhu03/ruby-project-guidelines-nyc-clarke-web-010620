require_relative '../config/environment'
# require 'tty-prompt'

def api_data(term, location)
    data = Yelp.search(term, location)
end

# def search_restaurant_info
# api_data

#     data.map do |restaurant|
#         attributes = {
#             name: restaurant["name"]

#         cusine_array = restaurant["categories"].map do |cuisine|
#                        cuisine["title"]
#                        end
#             type: cuisine_types.join(",")
#             location: restaurant["location"]["display_address"].join(" ")
#             rating: restaurant["rating"]
#         }
#     end
# end

#Output options for restaurant selection

def restaurant_options
    prompt = TTY::Prompt.new

    prompt.select('Which restaurant do you want to look into?') do |menu|
        api_data.map do |restaurant|
            menu.choice restaurant[:name], -> do
                puts "Here is some info about #{restaurant[:name]}!"
                puts "Type of Food: #{restaurant["categories"]}"
                puts "Location: #{restaurant["location"]["display_address"].join(" ")}"
                puts "Rating: #{restaurant["rating"]}"


            end
        end
    end
end