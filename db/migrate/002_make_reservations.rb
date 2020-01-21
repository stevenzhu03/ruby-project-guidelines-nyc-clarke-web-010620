class MakeReservations < ActiveRecord::Migration[4.2]
    def change
        create_table :reservations do |t|
            t.string :name_of_customer
            t.string :name_of_restaurant
            t.integer :number_of_people
            t.string :date
            t.string :time
            t.integer :customer_id
            t.integer :restaurant_id
        end
    end
end