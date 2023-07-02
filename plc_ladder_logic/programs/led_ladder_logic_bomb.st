PROGRAM part1c
  VAR
    Input0 AT %IX1.0 : BOOL;
    Output0 AT %QX1.0 : BOOL;
  END_VAR
  VAR
    TP0 : TP;
    Trigger0 : BOOL;
    Trigger1 : BOOL;
    CTU0 : CTU;
    TON0 : TON;
    SR0 : SR;
    R_TRIG1 : R_TRIG;
  END_VAR

  TP0(IN := Input0, PT := T#6s);
  Output0 := Input0 OR TP0.Q OR Trigger0 OR Trigger1;
  R_TRIG1(CLK := Input0);
  CTU0(CU := R_TRIG1.Q, PV := 6);
  Trigger0 := CTU0.Q;
  TON0(IN := Input0, PT := T#30s);
  SR0(S1 := TON0.Q);
  Trigger1 := SR0.Q1;
  Output0 := NOT(NOT(Input0) AND NOT(Trigger1) AND NOT(Trigger0));
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : part1c;
  END_RESOURCE
END_CONFIGURATION
