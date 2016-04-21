patron =  [1,1,1,2,2,2]
patron2 = [1,1,1,1,1,2]

use_bpm 60

notes0 = (ring :E4, :Fs4, :B4, :Cs5, :D5, :Fs4, :E4, :Cs5, :B4, :Fs4, :D5, :Cs5)
notes1 = (scale :E4, :chromatic)

live_loop :forlove do
  with_fx(:reverb, release: 4.2,  phase: 3.125, distort: 8) do
    patron.each do |p|
      with_fx(:gverb, reps: 1) do
        use_synth :mod_fm
        play notes0.choose, release: 0.333, amp: 1 if p == 1
      end
      use_synth  :dark_ambience
      cg = play (chord :e4, :minor7), release: [2.2, 0.32, 2].choose,
                amp: 3 if p == 2
      control cg, note: (chord :c3, :major)
      sample :drum_snare_hard, start: 0.2,
             finish: 0.17, rate: 1,
             amp: 1 if p == 1
      sleep 0.5 if p == 1
      with_fx(:echo) do
        sample ring(:guit_em9, :guit_harmonics, :guit_e_slide).tick, rate: [2, 4, 16].choose,
               release: 16, sustain: 4,
               amp: 1 if p == 2
      end
      sleep 0.5
    end
  end
end

live_loop :ofbooks do
  with_fx(:reverb, release: 2.2,  phase: 1.125, distort: 8) do
    patron.each do |p|
      use_synth :dark_ambience
      cg = play (chord :e2, '11+'), release: 1.4, amp: 5 if p == 1
      control cg, note: (chord :c3, :major)
      with_fx( :ixi_techno, release: 1.2, reps: 2) do
        sample :drum_heavy_kick, rate: 4,
               amp: 1 if p == 2
        sample :bd_haus, rate: 4, attack: 2.75,
               amp: 1 if p == 2
      end
      if p == 2
        sleep 0.25
      else
        sleep 0.5
      end
    end
  end
end

live_loop :ofclouds do
  with_fx(:gverb) do
    patron2.each do |p|
      with_fx :ixi_techno do
        sample lambda { [:ambi_piano, :drum_heavy_kick].choose }, rate: 2,
               start: 0.3, finish: 0.7,
               amp: 1 if p == 1
      end
      sample :ambi_piano, rate: 10.3,
             start: 0.5, finish: 1, amp: 1 if p == 1
      sleep 0.5
    end
  end
end