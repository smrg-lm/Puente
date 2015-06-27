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
    \tempo 4 = 35
    c'''8-^\ff
    s4 b'8-^
    s4 bes'''8-^
    
    s4 r4\fermata s4
    
    a''8-^
    s4 aes'''8-^
    s4 g''8-^
    s4 fis'1\pp %\break s4
  }

  \midi {}

  \layout {
    \context {
        \Staff
        %\remove "Accidental_engraver"
        %\remove "Key_engraver"
        %\remove "Clef_engraver"
        \remove "Bar_engraver"
        %\consists "Pitch_squash_engraver"
        \remove "Time_signature_engraver"
    }
  }
}
