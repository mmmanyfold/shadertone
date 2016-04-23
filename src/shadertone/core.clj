(ns shadertone.core
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

(inst-fx! external fx-reverb)

;; for the repl
;;(def lowpass (inst-fx! external fx-rlpf))


(defn refresh!
  "from the repl we can use this function to swap shaders on the fly
  with no arguments it plays default shader
  usage $ (refresh! disco)
  no .glsl extension needed or directory, as you can see below it add
  it to the name."
  ([]
   (t/start "examples/sine_dance.glsl"
            :width 640 :height 360
            :user-data {"t0" (atom {:synth nil :tap "t0"})}))
  ([shader]
   (t/start (str "examples/" shader ".glsl")
            :width 640 :height 360
            :user-data {"t0" (atom {:synth nil :tap "t0"})})))


(defn midi-listen []
  (on-event [:midi :note-on]
            (fn [e]
              (when (= (:name (:device e)) "Launchpad")
                (let [note (:note e)
                      vel  (:velocity e)]
                  (case note
                    0 (refresh! "disco")
                    1 (refresh! "redFrik")
                    (refresh!)))))
            ::keyboard-handler))

(midi-listen)

(defn -main [& args]
  (let []
    (refresh!)
    (Thread/sleep (* 55 60 1000))
    (println "Done.")
    ;;(ctl rf :gate 0) ;; fade out
    (Thread/sleep (* 3 1000))
    (t/stop)
    (stop)
    (System/exit 0)))
