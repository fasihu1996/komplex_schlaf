#set page(
  paper:"a4",
  header: context [
    #set text(size: 11pt)
    #align(left)[Fasih Uddin#h(1fr) 20238352]
    #set text(fill: red)
    ],
  footer: context  [
    #set align(right)
    #set text(size: 11pt, ligatures: true)
    #counter(page).display("1 of I", both: true)
  ],
  fill: rgb("#F2F0EF")
)
#set text(font:"New Computer Modern", size:13pt, fill: black)
#set par(justify:true)

= Testbericht für das Projekt: GS - Sleep Well G2
#set heading(level: 1, numbering: "1.")
== Einleitung
Es wird die Erzeugung eines Diagnosevorschlags auf Grundlage von Messdaten getestet. Die Messdaten werden dabei von einem Tool erzeugt, welches echte Messdaten simulieren soll. Ziel ist es, die korrekte Erstellung von Diagnosen basierend auf den erzeugten Messdaten sicherzustellen.
== Testumfang
Das Testobjekt hier ist die Diagnosefunktionalität der Schlafapnoe-Anwendung. Wenn ein behandelnder Arzt mit der Fachrichtung festgelegt wurde, können nach Auswahl des aktuellen Patienten die Messdaten geladen werden, um daraus einen Diagnosevorschlag zu erhalten. Die Messdaten werden mit Hilfe von einem Mockingtool erzeugt, welches unter Zunahme von Parametereinstellungen unterschiedliche Testdaten generiert.
Die Akzeptanzkriterien sind wie folgt:
+ Der behandelnde/aktuelle Arzt mit Fachrichtung kann festgelegt werden
+ Der aktuelle Patient kann festgelegt werden
+ Die Messdaten können geladen werden
+ Der Diagnosevorschlag wird auf Grundlage der Messdaten erstellt

== Methodik
Die Testfälle bestehen sowohl aus Positiv- und Negativtests. 
Die Testumgebung besteht aus den ausführbaren Javadateien (.jar), sowie den erzeugten Comma-Separated-Value-Dateien (.csv), welche die Messdaten für die Patienten enthalten. Als aktive Testumgebung wurde Java in der JDK-Version 24 auf macOS 15 Sequoia eingesetzt.
#set highlight(fill:green)
== Testprotokoll
Bei der Durchführung aller Testfälle wird der spezifizierte Arzt ausgewählt und Patient ausgewählt. Danach wird die verwendete Datei geladen und ein Diagnosevorschlag erstellt.
#table(
  columns: (auto,auto),
  [*Testfall*], [*01*],
  [Bezeichnung], [Diagnose durch Hausarzt von gesundem Patienten],
  [Voraussetzung], [Hausarzt, Patient 2025000001],
  [Eingabe], [AHI=3, gesunde Pulsoximetriewerte, keine Schlaflabormessung],
  [Verwendete Datei], [gesund_01_ahi3_pox1_sl0.csv],
  [Erwartetes Ergebnis], [Keine Berechtigung, Diagnose zu erstellen. Warnung wird angezeigt],
  [Tatsächliches Testergebnis], [Diagnose wird nicht erstellt, Warnung wird angezeigt],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#table(
  columns: (auto,auto),
  [*Testfall*], [*02*],
  [Bezeichnung], [Diagnose durch Hausarzt von Verdachtsfall],
  [Voraussetzung], [Hausarzt, Patient 2025000001],
  [Eingabe], [AHI=8, ungesunde Pulsoximetriewerte, keine Schlaflabormessung],
  [Verwendete Datei], [krank_01_ahi8_pox2_sl0.csv],
  [Erwartetes Ergebnis], [Verdacht auf milde Schlafapnoe, Überweisung ins Schlaflabor],
  [Tatsächliches Testergebnis], [Verdacht auf milde Schlafapnoe, Überweisung ins Schlaflabor],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: red)
#table(
  columns: (auto,auto),
  [*Testfall*], [*03*],
  [Bezeichnung], [Diagnose durch Hausarzt von falschem Patienten],
  [Voraussetzung], [Hausarzt, Patient 2025000002],
  [Eingabe], [AHI=3, gesunde Pulsoximetriewerte, keine Schlaflabormessung],
  [Verwendete Datei], [gesund_01_ahi3_pox1_sl0.csv],
  [Erwartetes Ergebnis], [nicht passende Patienten-ID wird erkannt, Diagnose wird nicht erstellt],
  [Tatsächliches Testergebnis], [Diagnose wird mit unpassendes Patientenwerten erstellt],
  [*Ergebnis*], [#highlight[Misserfolg]],
  [Fehlerbeschreibung], [Hauptfehler: unpassende Patientendaten werden trotzdem akzeptiert, es findet keine Prüfung der Patienten-ID statt]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [*04*],
  [Bezeichnung], [Diagnose durch Schlafmediziner von gesundem Patienten],
  [Voraussetzung], [Schlafmediziner, Patient 2025000001],
  [Eingabe], [AHI=3, gesunde Pulsoximetriewerte, gesunde Schlaflabormessung],
  [Verwendete Datei], [gesund_01_ahi3_pox1_sl1.csv],
  [Erwartetes Ergebnis], [Diagnose wird erstellt, keine Schlafapnoe, Rücküberweisung an Hausarzt],
  [Tatsächliches Testergebnis], [Diagnose wird erstellt, keine Schlafapnoe, Rücküberweisung an Hausarzt],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [*05*],
  [Bezeichnung], [Keine Diagnose ohne Schlaflabormessung möglich],
  [Voraussetzung], [Schlafmediziner, Patient 2025000001],
  [Eingabe], [AHI=18, kranke Pulsoximetriewerte, fehlende Schlaflabormessung],
  [Verwendete Datei], [krank_01_ahi18_pox2_sl0.csv],
  [Erwartetes Ergebnis], [Keine Diagnose möglich, fehlende Schlaflabormessung],
  [Tatsächliches Testergebnis], [Keine Diagnose möglich, fehlende Schlaflabormessung],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [06],
  [Bezeichnung], [Schlafmediziner überweist kranken Patienten an Neurologen],
  [Voraussetzung], [Schlafmediziner, Patient 2025000001],
  [Eingabe], [AHI=18, kranke Pulsoximetriewerte, korrekte Schlaflabormessung für zentrale Schlafapnoe mit Nervenleitung],
  [Verwendete Datei], [krank_01_ahi18_pox2_sl4.csv],
  [Erwartetes Ergebnis], [Verdacht auf Schlafapnoe, Überweisung an Neurologen],
  [Tatsächliches Testergebnis], [Verdacht auf Schlafapnoe, Überweisung an Neurologen],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#pagebreak()
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [07],
  [Bezeichnung], [Neurologe diagnostiert kranken Patienten],
  [Voraussetzung], [Neurologe, Patient 2025000001],
  [Eingabe], [AHI=18, kranke Pulsoximetriewerte, korrekte Schlaflabormessung für zentrale Schlafapnoe mit Nervenleitung],
  [Verwendete Datei], [krank_01_ahi18_pox2_sl4.csv],
  [Erwartetes Ergebnis], [Nervenleitung unterbrochen, zentrale moderate Schlafapnoe],
  [Tatsächliches Testergebnis], [Nervenleitung unterbrochen, zentrale moderate Schlafapnoe],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [08],
  [Bezeichnung], [Schlafmediziner überweist kranken Patienten an HNO und Neurologen],
  [Voraussetzung], [Schlafmediziner, Patient 2025000001],
  [Eingabe], [AHI=18, kranke Pulsoximetriewerte, korrekte Schlaflabormessung für gemischte Schlafapnoe durch Nervenleitung],
  [Verwendete Datei], [krank_01_ahi18_pox2_sl6.csv],
  [Erwartetes Ergebnis], [Verdacht auf Schlafapnoe, Überweisung an HNO und Neurologe],
  [Tatsächliches Testergebnis], [Verdacht auf Schlafapnoe, Überweisung an HNO und Neurologe],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [09],
  [Bezeichnung], [HNO konsultiert mit Neurologen],
  [Voraussetzung], [HNO, Patient 2025000001],
  [Eingabe], [AHI=18, kranke Pulsoximetriewerte, korrekte Schlaflabormessung für gemischte Schlafapnoe durch Nervenleitung],
  [Verwendete Datei], [krank_01_ahi18_pox2_sl6.csv],
  [Erwartetes Ergebnis], [Verdacht auf gemischte Schlafapnoe, Konsultation mit Neurologen],
  [Tatsächliches Testergebnis], [Gemischte Schlafapnoe, Konsultation mit Neurologen.],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [10],
  [Bezeichnung], [Neurologe konsultiert mit HNO],
  [Voraussetzung], [HNO, Patient 2025000001],
  [Eingabe], [AHI=18, kranke Pulsoximetriewerte, korrekte Schlaflabormessung für gemischte Schlafapnoe durch Nervenleitung],
  [Verwendete Datei], [krank_01_ahi18_pox2_sl6.csv],
  [Erwartetes Ergebnis], [Verdacht auf gemischte Schlafapnoe, Konsultation mit HNO],
  [Tatsächliches Testergebnis], [Gemischte Schlafapnoe, Konsultation mit HNO.],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [11],
  [Bezeichnung], [Fehlerhafte Schlaflabormessung wird erkannt],
  [Voraussetzung], [Schlafmediziner, Patient 2025000001],
  [Eingabe], [AHI=18, kranke Pulsoximetriewerte, fehlerhafte Schlaflabormessung],
  [Verwendete Datei], [krank_01_ahi18_pox2_sl7.csv],
  [Erwartetes Ergebnis], [fehlerhafte Schalflabormessung wird erkannt],
  [Tatsächliches Testergebnis], [Fehlermedlung für Schlaflabormessung wird angezeigt],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [*12*],
  [Bezeichnung], [Überweisung von Schlafmediziner an Neurologe für obstruktive Schlafapnoe],
  [Voraussetzung], [Schlafmediziner, Patient 2025000002],
  [Eingabe], [AHI=12, kranke Pulsoximetriewerte, korrekte Schlaflabormessung für zentrale Schlafapnoe durch Atemzentrum],
  [Verwendete Datei], [krank_02_ahi12_pox3_sl3.csv],
  [Erwartetes Ergebnis], [Verdacht auf moderate obstruktive Schlafapnoe, Überweisung an Neurologen],
  [Tatsächliches Testergebnis], [Verdacht auf moderate obstruktive Schlafapnoe, Überweisung an Neurologen],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [*13*],
  [Bezeichnung], [Diagnose durch Neurologe für obstruktive Schlafapnoe],
  [Voraussetzung], [Neurologe, Patient 2025000002],
  [Eingabe], [AHI=12, kranke Pulsoximetriewerte, korrekte Schlaflabormessung für zentrale Schlafapnoe durch Atemzentrum],
  [Verwendete Datei], [krank_02_ahi12_pox3_sl3.csv],
  [Erwartetes Ergebnis], [Diagnose von moderater zentraler Schlafapnoe],
  [Tatsächliches Testergebnis], [Diagnose von moderater zentraler Schlafapnoe],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: green)
#table(
  columns: (auto,auto),
  [*Testfall*], [*14*],
  [Bezeichnung], [Zu kurze Messung wird erkannt],
  [Voraussetzung], [Neurologe, Patient 2025000002],
  [Eingabe], [AHI=12, kranke Pulsoximetriewerte, korrekte Schlaflabormessung für zentrale Schlafapnoe durch Atemzentrum, Messdauer 1 Stunde],
  [Verwendete Datei], [krank_ahi12_pox3_sl3_kurz.csv],
  [Erwartetes Ergebnis], [Messdauer zu kurz],
  [Tatsächliches Testergebnis], [Fehler für zu kurze Messung wird angezeigt],
  [*Ergebnis*], [#highlight[Erfolg]],
  [Fehlerbeschreibung], [-]
)
#set highlight(fill: red)
#table(
  columns: (auto,auto),
  [*Testfall*], [*15*],
  [Bezeichnung], [Plausibilitätsprüfung für Messdatum],
  [Voraussetzung], [Neurologe, Patient 2025000002],
  [Eingabe], [AHI=12, kranke Pulsoximetriewerte, korrekte Schlaflabormessung für zentrale Schlafapnoe durch Atemzentrum, Messdatum liegt vor Geburtsdatum],
  [Verwendete Datei], [krank_ahi12_pox3_sl3_vorGeburt.csv],
  [Erwartetes Ergebnis], [Fehler bei Messdatum wird erkannt],
  [Tatsächliches Testergebnis], [Diagnose wird trotz falschem Datum erstellt],
  [*Ergebnis*], [#highlight[Misserfolg]],
  [Fehlerbeschreibung], [Hauptfehler: Das Erstelldatum der Messdaten wird nicht gegen das Geburtsdatum des Patienten geprüft.]
)
== Fazit und Empfehlungen

  *Gesamtergebnis: #highlight[Nicht bestanden]*

  Aufgrund der fehlenden Datenvalidierung von Messdaten bezüglich der hinterlegten Patienten-ID und dem Messdatum wurde dieser Akzeptanztest nicht bestanden.

  Es wird empfohlen, die Datenvalidierung für die Messdaten zu erweitern. Außerdem ist eine bessere Formulierung bei den Fehlermeldungen notwending, um den Anwender über den Hintergrund informieren zu können.
