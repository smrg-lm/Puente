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
    
    \time 3/4
    
    \tempo 4 = 45
    \override NoteHead #'style = #'cross ees'64\ffff r8 r16..
    \tempo 4 = 35
    \revert NoteHead #'style d''64^^ r8 r16..
    \tempo 4 = 45
    \override NoteHead #'style = #'cross cis'64 r8 r16..
    
    \tempo 4 = 65
    r2.
    
    \tempo 4 = 35
    ges'64 r8 r16..
    \tempo 4 = 45
    f'64 r8 r16..
    \revert NoteHead #'style e''64^^ r8 r16..

    \tempo 4 = 72
    r2.

    \tempo 4 = 45
    a''64^^ r8 r16..
    \tempo 4 = 35
    \override NoteHead #'style = #'cross aes'64 r8 r16..
    \tempo 4 = 50
    g'64 r8 r16..
    
    \tempo 4 = 65
    r2.
    
    \tempo 4 = 50
    c'64 r8 r16..
    \tempo 4 = 45
    b'64 r8 r16..
    \revert NoteHead #'style bes''64^^ r8 r16..
    
    \tempo 4 = 65
    r2.
    
    c'2.\pppp
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
        \remove "Stem_engraver"
        \remove "Beam_engraver"
    }
  }
}
