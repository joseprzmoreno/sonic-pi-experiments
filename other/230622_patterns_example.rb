t = 0.25
m = t * 4

patterns =
{
  'piano' =>
  {
    'p1' =>
    {
      'notes'   => [:C4, :D4, :E4, :C4, :D4, :E4, :G4, :r, :G4, :r],
      'durs'    => [t,   t,   t*2,  t,   t,  t*2,  t,   t,  t,  t ],
      'effects' => []
    },
    'p2' =>
    {
      'notes'   => [:E4, :G4, :C4, :E4, :G4, :C4, :F4, :r, :F4, :r],
      'durs'    => [t,   t,   t*2,  t,   t,  t*2,  t,   t,  t,  t ],
      'effects' => []
    }
  },
  'drum_bass_soft' =>
  {
    'p1' => [1,0,1,0,1,0,0,0,1,0]
  }
}

live_loop :piano do
  use_synth :piano
  10.times do
    play patterns['piano']['p1']['notes'].tick
    sleep patterns['piano']['p1']['durs'].tick
  end
  10.times do
    play patterns['piano']['p2']['notes'].tick
    sleep patterns['piano']['p2']['durs'].tick
  end
end

live_loop :drums do
  if patterns['drum_bass_soft']['p1'].tick == 1 then
    sample :drum_bass_soft
  end
  sleep t
end