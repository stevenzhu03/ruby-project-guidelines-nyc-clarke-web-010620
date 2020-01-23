class MakeReservations < ActiveRecord::Migration[5.2]
    def change
        create_table :reservations do |t|
            t.string :name_of_customer
            t.string :name_of_restaurant
            t.integer :number_of_people
            t.string :time
            t.integer :customer_id
            t.integer :restaurant_id
        end
    end
end