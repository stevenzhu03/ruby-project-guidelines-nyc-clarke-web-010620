require_relative '../config/environment'
require 'tty-prompt'


    def api_data(term, location)
        data = Yelp.search(term, location)
    end

    # def restaurant_option s
    #     prompt = TTY::Prompt.new
    # ​
    #     prompt.select("Which restaurant do you want to look into?") do |menu|
    #         api_data.map do |restaurant|
    #             menu.choice restaurant[:name], -> do
    #                 puts "Here is some info about #{restaurant[:name]}!"
    #                 puts "Type of Food: #{restaurant["categories"]}"
    #                 puts "Location: #{restaurant["location"]["display_address"].join(" ")}"
    #                 puts "Rating: #{restaurant["rating"]}"
    # ​
    # ​
    #             end
    #         end
    #     end
    # end

 

    def intro  # intro 
        puts "Welcome to your Reservation Manager!"
    end 

    def get_choices1 # getting 4 choices 

        prompt = TTY::Prompt.new 

        selection = prompt.select('How can I help you today?') do |menu|
            menu.default 3
        
            menu.choice 'Create Reservation', 1
            menu.choice 'Modify Reservation', 2
            menu.choice 'Cancel Reservation', 3
        end

        return selection 
    end 

    def get_info 
        prompt = TTY::Prompt.new 
        case 
            when get_choices1 = 'Create Reservation'
            city_choice = prompt.ask("What city are you dining in?")
            food_choice = prompt.ask("What kind of food?")
            number_choice = prompt.ask("For how many people?")
            time_choice = prompt.ask("What time?")
            customer_name = prompt.ask("Under what name should I make this reservation?")
            
        puts "Great! So you are looking for #{food_choice} in #{city_choice}
        
        for #{number_choice} people at #{time_choice}? (Yes/No)"
            answer_choice = gets.chomp

            
            if answer_choice == "Yes" || answer_choice == "yes"
                
                puts "Great! Here is a list of #{food_choice} near #{city_choice}"
                api_data(food_choice, city_choice)
               
                elsif answer_choice == "No" || answer_choice == "No"
                    runner

            else 
                puts "invalid key, try again"
                runner
            end 
        end
    end 


     ## new method for getting a list  

                #new_customer = Customer.create(name: customer_name)
                #new_restaurant = Restaurant.create(:name  , :cuisine , :location) => Restaurant table should have city and address 
                #Reservation.new(:name_of_customer customer_name, restau)
                
                # t.string :name_of_customer
                # t.string :name_of_restaurant
                # t.integer :number_of_people
                # t.string :date
                # t.string :time
                # t.integer :customer_id
                # t.integer :restaurant_id


    # def update_or_delete_reservation 

    # end 
    


    def runner
        intro 
        get_choices1
        get_info
        # update_or_delete_reservation 
    end 

    system"clear"  # clears screen 
    runner



    # binding.pry


    # Questions 
    #If we are using Api, what will we do with our migrations for Restaurant ? and do we still need Active Record 