PROGRAM part1b
  VAR
    Input0 AT %IX1.0 : BOOL;
    Output0 AT %QX1.0 : BOOL;
  END_VAR
  VAR
    TP0 : TP;
  END_VAR

  TP0(IN := Input0, PT := T#6s);
  Output0 := TP0.Q;
  Output0 := Input0;
  Output0 := NOT(NOT(Input0));
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : part1b;
  END_RESOURCE
END_CONFIGURATION
