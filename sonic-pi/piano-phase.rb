# Reich Phase + other samples
# Steve Reich's Piano Phase
# See:  https://en.wikipedia.org/wiki/Piano_Phase

_one = "~/local/dviramontes/llu/sonic-pi/00.wav"
load_samples [_one]
use_bpm 20
use_synth :mod_tri

notes0 = (ring :E4, :Fs4, :B4, :CS5, :D5, :Fs4, :E4, :Cs5, :B4, :Fs4, :D5, :Cs5)
notes1 = (ring :E4, :Fs4, :B4, :CS5, :D5, :Fs4, :E4, :Cs5, :B4, :Fs4, :D5, :Cs5) # 7 # 9

# =begin

## 1
live_loop :slow do
  uncomment do
    sample _one, rate: -2, amp: 0.3  # 5
    play notes0.tick, release: 2.6, amp: 1.0
  end
  sleep 1
end

## 2
live_loop :fast do
  uncomment do
    with_synth :subpulse do
      #sample _one, rate: 1, start: 0.1, finish: 1.0, amp: 0.17 # 6
      play notes1.tick, release: 0.6, amp: 1.34 # 8
    end
  end
  sleep 0.5
end

## 3
live_loop :fastest do
  uncomment do
    with_synth :piano do
      play notes1.tick, release: 2, amp: 1.75
    end
  end
  sleep 0.25
end

## 4
live_loop :fastestest do
  uncomment do
    with_synth :piano do
      play notes1.tick, release: 2, amp: 1
    end
  end
  sleep 0.125
end

#=end