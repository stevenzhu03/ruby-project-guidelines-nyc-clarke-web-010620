class MakeRestaurants < ActiveRecord::Migration[5.2]
    def change
        create_table :restaurants do |t|
            t.string :name
            t.string :type_of_food
            t.string :location
            t.string :open_time
            t.string :close_time
            t.float :rating #restrict to one decimal place, can't go below 0
        end
    end
end