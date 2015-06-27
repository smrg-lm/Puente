\version "2.12.3"

\paper {
  %#(define dump-extents #t)
  
  %line-width = 160\mm - 2.0 * 0.4\in
  %ragged-right = ##t
  indent = 0\mm
  %force-assignment = #""
  %line-width = #(- line-width (* mm  3.000000))
}

\score {
  \new Staff {
    \set Staff.midiInstrument = #"flute"
    \tempo 4 = 34

    \time 3/1
    c''1:32\pppp_"(inaudible)"^"frullato" ais'1:32 b'1:32
    a'1:32 aes'1:32 g'1:32
    e''1^"(n.f.)" f'1:32 ges'1:32
    d'1:32 cis'1:32 ees'1:32
  }

  \midi {}

  \layout {
    \context {
        \Staff
        %\remove "Accidental_engraver"
        %\remove "Key_engraver"
        %\remove "Clef_engraver"
        \remove "Bar_engraver"
        \consists "Pitch_squash_engraver"
        \remove "Time_signature_engraver"
    }
    \context {
        \Voice
        %\remove "Stem_engraver"
        %\remove "Beam_engraver"
    }
  }
}