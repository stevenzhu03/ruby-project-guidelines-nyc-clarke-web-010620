class MakeRestaurants < ActiveRecord::Migration[5.2]
    def change
        create_table :restaurants do |t|
            t.string :name
            t.string :type_of_food
            t.string :location
            t.float :rating #restrict to one decimal place, can't go below 0
        end
    end
end