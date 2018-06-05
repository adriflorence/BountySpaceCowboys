require('pry-byebug')
require_relative('bounty_hunter.rb')

BountyHunter.delete_all()

hunter1 = BountyHunter.new({
  'name' => 'Rick Deckard',
  'species' => 'Human',
  'bounty_value' => '1000',
  'danger_level' => '50',
  'last_known_location' => 'Earth'
  })

hunter2 = BountyHunter.new({
  'name' => 'Boba Fett',
  'species' => 'Human',
  'bounty_value' => '800',
  'danger_level' => '100',
  'last_known_location' => 'Tatooine'
  })

hunter3 = BountyHunter.new({
  'name' => 'Spike Spiegel',
  'species' => 'Martian',
  'bounty_value' => '1200',
  'danger_level' => '20',
  'last_known_location' => 'Jupiter'
  })

  hunter1.save()
  hunter2.save()
  hunter3.save()

  hunters = BountyHunter.all()

  hunter1.bounty_value = "1500"
  hunter1.update()

  hunter1.delete()

  # Supdated_values = BountyHunter.all()

  found_bounty = BountyHunter.find_by_name('Spike Spiegel')

  binding.pry
  nil
