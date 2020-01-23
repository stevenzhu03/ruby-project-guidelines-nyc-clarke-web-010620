# require_relative '../config/environment'
# require 'tty-prompt'
$prompt = TTY::Prompt.new

class ReservationApp

    def intro  # intro 
                puts "                       
                     -:::::::-.   .-::-::                             
                      `--::::::-`  `-:-::`                            
                         ```-:::-   `::-:.                            
                              -:::`  .::/-                            
                           ```.-:::``.:::-`````                       
                      `..--...`............-.--...                    
                   `.---.```               ` ````-.-.                 
                 `---````` ````                  ` `--.`              
               `-:.```.....```````               ``...::.             
              `--` ....```.-.``````            `.-.``.`--.            
             `-.``..`   `` `..`````           `--` `    `:.           
             .-` `..    .-` `-`````  `-..     `.` `--`   -:`      `   
            `--```.-`   ``  ..`````  `:--     `..  ``   `-:.     .--- 
  ` ..--.   `-- ````-.``` `-.``..``            `.-`` `.-.---    .:``:`
 ...--:--`  `.. ```.``.....```````               .....-```-.   `-` .- 
 ---..:-..   .-. ```````````````                     ``  .-`  `:.  :` 
 `-:-.-:--`  `--`  ```````````                          .-.  `-.  --  
  --.:----.    .:.                                 `  `.-.   --  .:`  
   ---.  `--`   .--.`                        `.-.````---`  `--` `-`   
    ...````.-.    `--..`` `             `..`---------.`   `--```-`    
      .....`.-.     `..-:--......`.``...`--.-:---::`     `--..-.`     
         `.--.-......```...`......-----.-...``....-......--.-.`       
           --.-:.`````` ````    `         `   `` ``````.:---:`        
          `-. `:-.`.----.-.--              ``--.--..```---`-.`        
           `-.`---..`       -`              `-`    ...----.-`         
             .-...         `-`              `-.       `.-..           
                `         `:.               `-.                       
                          `:`              `.-.                       
                           .-.      `--    .-.                        
                            `.:-`    :-..---`                         
                              -::.  `..`.:-                           
                              ``-:`     `:.                           
                   ```` ``` `   `::   `-:.                            
                ````````````````  .----.   `"                    
        puts "Welcome to your Reservation Manager!"
    end 



    def get_choices1 # getting 3 choices 

        prompt = TTY::Prompt.new 

        selection = prompt.select('How can I help you today?') do |menu|
            menu.default 3
        
            menu.choice 'Create Reservation', 1
            menu.choice 'Modify Reservation', 2
            menu.choice 'Cancel Reservation', 3
        end

        return selection 
    end 



    def create_resevation #building choice 1
        prompt = TTY::Prompt.new 
        case 
            when get_choices1 = 'Create Reservation'
            @city_choice = prompt.ask("What city are you dining in?")
            @food_choice = prompt.ask("What kind of food?")
            @number_choice = prompt.ask("For how many people?")
            @time_choice = prompt.ask("What time?")
            customer_name = prompt.ask("Under what name should I make this reservation?")
            @customer = Customer.create(name: customer_name)
            
            puts "\nGreat! So you are looking for #{@food_choice} in #{@city_choice} \nfor #{@number_choice} people at #{@time_choice}? (Yes/No)"
            answer_choice = gets.chomp

            
            if answer_choice == "Yes" || answer_choice == "yes" #Begins process to build reservation
                
                puts "\nGreat! Here is a list of #{@food_choice} near #{@city_choice}"

                data = Yelp.search(@food_choice, @city_choice)
                menu_option(data) #Provides menu options for restaurants
                
            elsif answer_choice == "No" || answer_choice == "No"
                runner

            else 
                puts "invalid key, try again"
                runner
            end 
        end
    end 

    def menu_option(data) #Provides menu options for restaurants, allows us to create reservation or go back to list
    prompt = TTY::Prompt.new 
    prompt.select('Which restaurant do you want to look into?') do |menu|
        data.map do |restaurant|
            menu.choice restaurant["name"], -> do
                restaurant_name = restaurant["name"]
                type_of_food = restaurant["categories"][0]["title"]
                location = restaurant["location"]["display_address"].join(" ")
                rating = restaurant["rating"]
                price = restaurant["price"]
                puts "\nHere is some info about #{restaurant_name}!" 
                puts "Type of Food: #{type_of_food}"
                puts "Location: #{location}"
                puts "Rating: #{rating}"
                puts "Price: #{price}"
                puts "Phone: #{phone = restaurant["display_phone"]}"
                puts "\n"
                
                
                prompt.select('Would you like to make a reservation here?') do |menu|
                    menu.choice 'Make A Reservation!', -> do
                    @restaurant = Restaurant.create(name: restaurant_name, type_of_food: type_of_food, location: location, rating: rating)
                    Reservation.create(name_of_customer: @customer.name, name_of_restaurant: restaurant_name, number_of_people: @number_choice, time: @time_choice, customer_id: @customer.id, restaurant_id: @restaurant.id)
                    puts "Great, Reservation was successfully made!"
                    end
                    menu.choice 'Go Back To Restaurant Options', -> {menu_option(data)}
                end

            end
        end
    end
end

    def modify_reservation
        prompt = TTY::Prompt.new 
        case 
            when get_choices2 = 'Modify Reservation'


        end
    end


    def cancel_reservation
        prompt = TTY::Prompt.new 
        case 
            when get_choices2 = 'Modify Reservation'


        end
    end
    # def restaurant_options
    #     prompt = TTY::Prompt.new

    #     data = Yelp.search(food_choice, city_choice)
    
    #     prompt.select('Which restaurant do you want to look into?') do |menu|
    #         data.map do |restaurant|
    #             menu.choice restaurant[:name], -> do
    #                 puts "Here is some info about #{restaurant[:name]}!"
    #                 # puts "Type of Food: #{restaurant["categories"]}"
    #                 puts "Location: #{restaurant["location"]["display_address"].join(" ")}"
    #                 puts "Rating: #{restaurant["rating"]}"
    
    #             end
    #         end
    #     end
    # end

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
        create_resevation
        # update_or_delete_reservation 
    end 

end