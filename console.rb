require('pry-byebug')
require_relative('property')


property1 = Property.new({'address' => '101 Ugly Code Street',
                          'value' => 45000,
                          'number_of_bedrooms' => 2,
                          'year_built' => 1965
                          })

property2 = Property.new({'address' => '5 Pretty Code Avenue',
                          'value' => 750000,
                          'number_of_bedrooms' => 28,
                          'year_built' => 1875
                          })


property1.save()


property1.value = 35000
property1.update()

property1.delete





binding.pry
nil
