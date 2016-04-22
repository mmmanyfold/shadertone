(ns #^{:author "Roger Allen"
       :doc    "Shadertoy meets Overtone.  A demonstration for 'lein run'"}
shadertone.core
  (:use [overtone.live])
  (:require [shadertone.tone :as t])
  (:gen-class))

; Depending on your audio setup (external interfaces, etc...) you might need
; to try a couple different buses before finding what you are looking for.
; Start at index zero and go upward.
(definst external []
         (sound-in 0))

; Start routing the external input to the mixer
(external)

;;(def lowpass (inst-fx! external fx-rlpf))

;; See examples/00demo_intro_tour.clj for the example code that was
;; once here.

(inst-fx! external fx-reverb)

;; for the repl
;;(def lowpass (inst-fx! external fx-rlpf))

(defn -main [& args]
  (let []
    (t/start "examples/sine_dance.glsl"
             :width 640 :height 360
             :user-data {"t0" (atom {:synth nil :tap "t0"})})
    (println "Playing a 60 second demo inspired by")
    (println "https://twitter.com/redFrik/status/329311535723839489\nEnjoy...")
    (Thread/sleep (* 55 60 1000))
    (println "Done.")
    ;;(ctl rf :gate 0) ;; fade out
    (Thread/sleep (* 3 1000))
    (t/stop)
    (stop)
    (System/exit 0)))
