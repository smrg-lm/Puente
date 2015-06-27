\version "2.12.3"

\paper {
  %#(define dump-extents #t)
  
  %line-width = 160\mm - 2.0 * 0.4\in
  %ragged-right = ##t
  indent = 0\mm
  %force-assignment = #""
  %line-width = #(- line-width (* mm  3.000000))
}

% \set Timing.defaultBarType = "dashed"

\score {
  \new Staff {
    \set Staff.midiInstrument = #"flute"
    \tempo 4 = 50
    
    \time 11/8 \set Timing.defaultBarType = "none" g''4--(\p\< g''4-- g''4--)\f fis'8-> a'''2\sff\fermata \breathe
    \time 15/8 g''4--(\p\< g''4-- g''4--)\f e'8-> fis'''2\sff\fermata( f'''2\pp\fermata) \breathe \break
    \time 7/4 e'4\pp\<( ges''2\fermata <<f'''1\fermata) {s4 s4\> s4 s4\pp}>> \breathe
    \time 4/2 ees'2\pp\<_( g'''2\> d'1\fermata\pp) \breathe
    \time 5/2 f''2\pp_( ees'2\< g'''2\>\fermata d'1\pp\fermata)
  }

  \midi {}

  \layout {
    \context {
        \Staff
        %\remove "Accidental_engraver"
        %\remove "Key_engraver"
        %\remove "Clef_engraver"
        %\remove "Bar_engraver"
        %\consists "Pitch_squash_engraver"
        \remove "Time_signature_engraver"
    }
  }
}
