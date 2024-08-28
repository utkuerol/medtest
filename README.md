# medtest

Cross-platform mobile app for practicing for the mandatory aptitude test for medical studies in Switzerland (EMS).

## Categories 

```<Category code>:<title>```

- A: Muster zuordnen
- B: Med.-naturwiss. Grundverständnis
- C: Schlauchfiguren 
- D: Quantitative und formale Probleme
- E: Figuren/Fakten (Einlesephase --> Reproduktionsphase)
  - E1: Figuren
  - E2: Fakten
- F: Textverständnis
- G: Diagramme und Tabellen
- H: Konzentration und sorgfältiges Arbeiten
  - H1: numerical
  - H2: alphabetical

## Question Types 

Types of questions regarding presentation logic.

- textMultipleChoice
  - B
  - D
- imageMultipleChoice
  - A
- imageQuestionTextMultipleChoice
  - C
  - G
- longTextMultipleChoice
  - F
- concentrationMatrix
  - H1
  - H2
- multiPhaseE1
  - initphase = custom
  - reproductionphase = imageMultipleChoice
- multiPhaseE2
  - initphase = custom
  - reproductionphase = textMultipleChoice 
