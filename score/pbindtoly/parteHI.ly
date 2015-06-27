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
% negra + semi corchea = 150 (negra = 187.5)
% seed 3008 en linux

\score {
  \new Staff {
    \set Staff.midiInstrument = #"flute"
    \tempo 4 = 187
    
    \time 24/16 \set Timing.defaultBarType = "dashed" e''8.\mf dis''8([ f''8 d''8 e''8 f''8 e''8 dis''8 f''8 d''8 dis''8.)]
    
    \time 1/8 r8
    
    \time 24/16  e''8. dis''8([ f''8 e''8 f''8 d''8 f''8 d''8 f''8 d''8 g'''8.)]
    
    \time 3/16 r8.
    
    \time 21/16  d''8([ dis''8 ges'''8 f''8 d''8 f''8 d''8 f'''8 e'8 d''8.)]
    
    \time 1/8 r8
    
    \time 5/16  f''8([ dis''8.)]
    \time 8/16  f''8. dis''8([ e''8.)]
    \time 17/16  dis''8([ e''8 e'''8 ees''8 d''8 dis''8 f''8 d''8.)]
    
    \time 3/16 r8.
    
    \time 13/16  ges'''8([ f''8 e''8 dis''8 dis'8 g'''8.)]    
    \time 11/16  e''8([ dis''8 f''8 dis''8 fis'''8.)]
    \time 5/16  d''8([ dis'8.)]
    
    \time 3/16 r8.
    
    \time 31/16  dis''8([ e''8 e'''8 f''8 e''8 d''8 f''8 d''8 f''8 e''8 d''8 dis''8 f''8 e''8 f''8.)]
    
    \time 1/4 r4
    
    \time 5/16  f'''8([ fis'''8.)]
    \time 5/16  e'''8([ d'8.)]
    \time 11/16  f''8([ dis''8 e''8 d'8 fis'''8.)]
    
    \time 1/8 r8
    
    \time 19/16  d''8([ dis''8 e''8 dis''8 dis'8 ees''8 d''8 e''8 f''8.)]
    \time 13/16  dis''8([ e''8 d''8 f''8 d''8 e''8.)]
    
    \time 3/16 r8.
    
    \time 12/16  e'8. dis'8([ f''8 d''8 e''8.)]
    \time 15/16  dis''8([ e''8 f''8 d''8 e''8 dis''8 f''8.)]
    \time 7/16  d''8([ ees''8 d''8.)]
    
    \time 1/4 r4
    
    \time 16/16  dis''8. e'''8([ e'8 dis''8 g'''8 d'8 e''8.)]
    \time 7/16  f''8([ cis'8 f''8.)]    
    \time 16/16  e''8. cis'8([ e''8 g'''8 dis''8 fis'''8 d''8.)]
    
    \time 3/16 r8.
    
    \time 7/16  d'8([ d''8 dis''8.)]
    \time 5/16  e'''8([ dis''8.)]
    \time 11/16  g'''8. dis''8. f''8([ d'8.)]
    \time 14/16  g'''8. dis''8([ cis'8 g'''8 ges'''8 f''8.)]
    
    \time 1/4 r4
    
    \time 20/16  e''8. f''8([ e''8 cis'8 fis'''8 d''8 e'8 e''8 d''8.)]
    \time 5/16  e''8([ d''8.)]
    \time 8/16  dis''8. e'''8([ f'''8.)]
    
    \time 3/16 r8.
    
    \time 10/16  f''8. e''8([ d''8 fis'''8.)]
    \time 9/16  e'''8([ d'8 dis'8 f'''8.)]
    
    \time 1/8 r8
    
    \time 51/16  e''8([ dis''8 dis'8 f''8 d''8 ees''8 d''8 f''8 e''8 d''8 dis''8 ges'''8 f'''8 f''8 d''8 fis'''8 dis''8 f''8 d''8 e''8 d''8 f'''8 cis'8 e''8 f''8.)]
    
    \time 1/8 r8
    
    \time 8/16  e''8. f''8([ d'8.)]
    \time 5/16  d''8([ f''8.)]
    \time 14/16  d''8. ges'''8([ f'''8 g'''8 e''8 e'''8.)]
    \time 9/16  e''8([ cis'8 f''8 cis'8.)]
    \time 5/16  e''8([ dis''8.)]
    
    \time 1/4 r4
    
    \time 7/16  dis'8([ dis''8 e''8.)]
    \time 11/16  dis''8([ g'''8 d''8 dis'8 f''8.)]
    \time 5/16  dis''8([ f''8.)]
    \time 8/16  e''8. f''8([ e''8.)]
    
    \time 1/8 r8
    
    \time 17/16  f''8([ dis''8 e''8 f'''8 e'8 e''8 d'8 f''8.)]
    
    \time 1/8 r8
    
    \time 21/16  e''8. d'8. f''8([ dis'8 e'''8 f''8 f'''8 dis'8 f''8.)]
    \time 5/16  e'''8([ f''8.)]
    \time 7/16  ees''8([ d''8 d'8.)]
    
    \time 1/8 r8
    
    \time 13/16  e'''8([ ees''8 d''8 dis''8 e'''8 dis''8.)]
    \time 5/16  e'8([ ges'''8.)]
    \time 5/16  f''8([ dis'8.)]
    
    \time 1/8 r8
    
    \time 9/16  dis''8([ g'''8 ees'8 d''8.)]
    \time 5/16  e'8([ ees'8.)]
    \time 5/16  d''8([ f''8.)]
    \time 8/16  e'''8. e''8([ e'''8.)]
    \time 9/16  d'8([ f''8 dis''8 f''8.)]
    
    \time 1/8 r8
    
    \time 11/16  dis'8([ dis''8 cis'8 f''8 e''8.)]
    \time 5/16  g'''8([ cis'8.)]
    \time 15/16  ees''8. d''8. d'8([ f''8 ges'''8 f'''8.)]
    
    \time 1/8 r8
    
    \time 18/16  e'''8. fis'''8([ e'8 cis'8 dis'8 f''8 e''8 d'8.)]
    \time 5/16  d''8([ f''8.)]
    \time 7/16  ees''8([ d''8 e'8.)]
    \time 5/16  d'8([ fis'''8.)]
    
    \time 3/16 r8.
    
    \time 18/16  cis'8. d'8([ d''8 f'''8 d''8 d'8 f''8 dis''8.)]
    \time 10/16  cis'8. dis'8([ g'''8 e'''8.)]
    \time 5/16  ges'''8([ f'''8.)]
    \time 5/16  fis'''8([ ees''8.)]
    
    \time 3/16 r8.
    
    \time 8/16  d''8. ges'''8([ f''8.)]
    \time 9/16  e'''8([ dis'8 dis''8 fis'''8.~]
    \time 4/4 fis'''1\fermata)~ fis'''1\fermata~ fis'''1\fermata~ fis'''1\fermata
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
