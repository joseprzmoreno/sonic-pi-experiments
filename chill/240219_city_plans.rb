use_bpm 100
base = '/home/jose/projects/sonic-pi-experiments/samples/TR808WAV/'
bd_ = base + '/BD/BD7575.WAV'
cym_ = base + 'CH/CH.WAV'
snare_ = base + 'SD/SD1025.WAV'
bsc = scale(:D3, :minor_pentatonic)
sc = scale(:D3, :minor_pentatonic, num_octaves: 2)
set_volume! 1

live_loop :r do
  bd_pat = [0,4,6,8,12]
  snare_pat = [0,2,4,6,8,10,12,14]
  hat_pat = [0,1,2,4,5,6,8,10,12,13,14,15]
  16.times do |i|
    sample bd_, amp: 8 if bd_pat.include?(i)
    sample snare_, amp: 4 if snare_pat.include?(i)
    sample cym_ if hat_pat.include?(i)
    sleep 0.25
  end
end

live_loop :bass, sync: :r do
  #stop
  use_random_seed [5000].tick(:rsb)
  use_synth :hollow
  use_synth_defaults sustain: 4
  bsc_ = bsc.shuffle.take(4)
  4.times do
    play chord(bsc_.tick(:bsc), '6'), amp: 4
    sleep 4
  end
end

live_loop :square, sync: :r do
  #stop
  use_random_seed [2000,5000,7000,8000].tick(:rs)
  use_synth :square
  use_synth_defaults attack: 0.05, sustain: 0.1, release: 0.1, amp: 0.6
  ini = rrand_i(0,5)
  pat = [ini, ini+2, ini+1, ini+3]
  pat = [ini, ini+4, ini+2, ini+6] if one_in(3)
  4.times do
    4.times do
      pan_ = rrand(-1, 1)
      with_fx :reverb do
        with_fx :nrbpf do
          n = pat.tick(:sp)
          in_thread do
            4.times do
              sleep 1
              play sc[n+24] if one_in(3)
            end
          end
          in_thread do
            sleep 0.25
            play sc[n+12] if one_in(4)
          end
          play sc[n], pan: pan_
        end
      end
      sleep [0.25,0.5].tick(:durs2)
    end
    sleep 1
  end
end

fadeout = 0
live_loop :fadeout, sync: :r do
  stop if fadeout == 0
  vol = 1
  10000.times do
    set_volume! vol
    vol = vol - 0.01
    sleep 0.1
  end
end
