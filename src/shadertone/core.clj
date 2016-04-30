(ns shadertone.core
  (:use [overtone.live])
  (:require [shadertone.tone :as t]
            [clojure.java.shell :refer [sh]])
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

(defn send-shell-cmd [n]
  (let [cmd (format "tell application \"System Events\" to keystroke \"%s\" using {command down}" n)]
    (sh "osascript" "-e" cmd)))

(defn refresh!
  "from the repl we can use this function to swap shaders on the fly
  with no arguments it plays default shader
  usage $ (refresh! disco)
  no .glsl extension needed or directory, as you can see below it add
  it to the name."
  ([]
   (let []
     (t/start "examples/0.glsl"
              :width (/ 1440 1.5) :height 900
              :user-data {"t0" (atom {:synth nil :tap "t0"})})
     (send-shell-cmd 1)))
  ([shader]
   (let []
     (t/start (str "examples/" shader ".glsl")
              :width (/ 1440 1.5) :height 900
              :user-data {"t0" (atom {:synth nil :tap "t0"})})
     (if (= shader "9") (send-shell-cmd 0) (send-shell-cmd (str (+ (read-string shader) 1))))
     )))

(defn unglitch! []
  (let [cmd "tell application \"System Events\" to keystroke {tab} using {command down}"]
    (sh "osascript" "-e" cmd)
    (sh "osascript" "-e" cmd)))

(defn midi-listen []
  (on-event [:midi :note-on]
            (fn [e]
              (when (= (:name (:device e)) "Launchpad")
                (let [note (:note e)
                      vel  (:velocity e)]
                  (println note)
                  (Thread/sleep 1000)
                  (case note
                    0 (refresh! "0")
                    1 (refresh! "1")
                    2 (refresh! "2")
                    3 (refresh! "3")
                    4 (refresh! "4")
                    5 (refresh! "5")
                    6 (refresh! "6")
                    7 (refresh! "7")
                    8 (unglitch!)
                    16 (refresh! "8")
                    17 (refresh! "9")
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
