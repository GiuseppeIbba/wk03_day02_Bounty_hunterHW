require('pry-byebug')
require_relative('./models/bounty')

# Bounty.delete_all()

bounty1 = Bounty.new({

  'name' => 'Giuseppe',
  'species' => 'human',
  'bounty_value' => '100',
  'favourite_weapon' => 'gun'
  })

  bounty2 = Bounty.new({

    'name' => 'Robert',
    'species' => 'Animal',
    'bounty_value' => '200',
    'favourite_weapon' => 'Sword'
    })


bounty1.save()
bounty2.save()
# Bounty.find(30)


# bounty_list = Bounty.all()
bounty = Bounty.find(46)

binding.pry
nil
