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
    \tempo 4 = 65

    \time 11/8 \set Timing.defaultBarType = "none" e'4_-^\fermata\mf(
    \override Stem #'stroke-style = #"grace" \small fis'''8->\f) \normalsize \breathe
    g''4-- g''4-- g''4-- r4\fermata
    \time 21/8 fis'4_-^\fermata\mf(
    \override Stem #'stroke-style = #"grace" \small a'''8->\f) \normalsize \breathe
    g''4-- g''4-- g''4--
    %{\time 6/4%} f''4-- f''4-- f''4-- f''4\fermata\mp\>( e''4\fermata\!) r4\fermata \break
    \time 1/8 s8 % esconde la barra en el salto de línea
    \time 6/4 \bar "|:" \mark "x3" e'4--\fermata\mf fis'''2--\fermata ees'4--\fermata g'''2--\fermata  \bar  ":|"
    \time 1/4 r4\fermata
    \time 5/8 \bar "|:" f''4\mp\>\fermata e''4\!\fermata r8\fermata \bar ":|"
    \time 1/4 r4\fermata
    \time 4/4 << fis''1\pp\<\fermata { s2 s4\> s4\! } >>
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