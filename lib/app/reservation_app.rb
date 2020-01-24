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



    def get_choices # getting 3 choices 
        prompt = TTY::Prompt.new

        selection = prompt.select('How can I help you today?') do |menu|
            menu.default 3
        
            menu.choice 'Create Reservation', 1
            menu.choice 'Modify Reservation', 2
            menu.choice 'Cancel Reservation', 3
        end

        # puts selection
        return selection 
    end 



    def create_resevation #building choice 1
        prompt = TTY::Prompt.new

            
            @city_choice = prompt.ask("What city are you dining in?")
            @food_choice = prompt.ask("What kind of food?")
            @number_choice = prompt.ask("For how many people?")
            @time_choice = prompt.ask("What time?")
            customer_name = prompt.ask("Under what name should I make this reservation? (Please enter full name)")
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

    def menu_option(data) #Provides menu options for restaurants, allows us to create reservation or go back to list
        prompt = TTY::Prompt.new

        prompt.select('Which restaurant do you want to look into?') do |menu|
            data.map do |restaurant|
                menu.choice "#{restaurant["name"]} #{restaurant["price"]}", -> do
                    restaurant_name = restaurant["name"]
                    type_of_food = restaurant["categories"][0]["title"]
                    location = restaurant["location"]["display_address"].join(" ")
                    rating = restaurant["rating"]
                    price = restaurant["price"]
                    phone = restaurant["display_phone"]
                    review_count = restaurant["review_count"]
                    puts "\nHere is some info about #{restaurant_name}!" 
                    puts "Type of Food: #{type_of_food}"
                    puts "Location: #{location}"
                    puts "Rating: #{rating}"
                    puts "Review Count: #{review_count}"
                    puts "Price: #{price}"
                    puts "Phone: #{phone}"
                    puts "\n"
                    
                    
                    prompt.select('Would you like to make a reservation here?') do |menu|
                        menu.choice 'Make A Reservation!', -> do
                        @restaurant = Restaurant.create(name: restaurant_name, type_of_food: type_of_food, location: location, rating: rating)
                        Reservation.create(name_of_customer: @customer.name, name_of_restaurant: restaurant_name, number_of_people: @number_choice, time: @time_choice, customer_id: @customer.id, restaurant_id: @restaurant.id)
                        puts "Great, Reservation was successfully made!"
                        # runner 
                        end
                        menu.choice 'Go Back To Restaurant Options', -> {menu_option(data)}
                    end
                end
            end
        end
    end


    def modify_reservation
        prompt = TTY::Prompt.new
        
            name = prompt.ask("Under what name is the reservation?")
            customer = Customer.find_by(name: name)
            if customer 
                reservation = Reservation.find_by(name_of_customer: customer.name)

                prompt.select("Sure #{name} what would you like to change?") do |menu| 
                    menu.choice 'Change time', -> do
                        puts "Hey #{customer.name} your current reservation is at #{reservation.time}."
                        new_time = prompt.ask("What time would you like to change it to?")
                        reservation.update(time: new_time)
                        puts "Great your reservation at #{reservation.name_of_restaurant} has been rescheduled to #{new_time}."
                    end
                        
                    menu.choice 'Change number of people', -> do 
                        puts "Hey #{customer.name} your current reservation is for #{reservation.number_of_people}."
                        new_number = prompt.ask("For how many people should I update your reservation?")
                        reservation.update(number_of_people: new_number)
                        puts "Great your reservation at #{reservation.name_of_restaurant} is now for #{new_number}."
                    end 
                end 

            else 
                puts "No reservation found under #{name}"
                modify_reservation
            end 

    end
    


    def delete_reservation
        prompt = TTY::Prompt.new
        name = prompt.ask("Under what name is the reservation? (Case Sensitive)")
        customer = Customer.find_by(name: name)
        if customer 
            reservation = Reservation.find_by(name_of_customer: customer.name)
            prompt.select ("Are you sure?") do |menu|
                menu.choice 'Yes, cancel my reservation', -> do 
                    reservation.delete
                    puts 'Your reservation was canceled'
                    puts '-----------------------------'
                end 
                menu.choice 'No, keep it as scheduled.', -> do 
                    runner
                end 
            end 
        else 
            puts "No reservation found under #{name}"
            delete_reservation
        end 
    end    


    def runner
        intro 

        selection = get_choices

        if selection == 1
        create_resevation
        elsif selection == 2
             modify_reservation
        else 
            delete_reservation
        end 
        
    end 

end