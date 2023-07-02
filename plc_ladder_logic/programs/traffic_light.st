PROGRAM part3
  VAR
    VehSensor AT %IX0.0 : BOOL;
    PedXINGButton AT %IX0.1 : BOOL;
    VehRedLight AT %QX0.0 : BOOL;
    VehYellowLight AT %QX0.1 : BOOL;
    VehGreenLight AT %QX0.2 : BOOL;
    PedRedLight AT %QX0.3 : BOOL;
    PedGreenLight AT %QX0.4 : BOOL;
  END_VAR
  VAR
    State0 : BOOL := True;
    State1 : BOOL;
    State2 : BOOL;
    State3 : BOOL;
    TP0 : TP;
    SR0 : SR;
    SR1 : SR;
    TON0 : TON;
    TON1 : TON;
    SR2 : SR;
    SR3 : SR;
    TON2 : TON;
  END_VAR

  VehGreenLight := State0;
  TP0(IN := PedXINGButton AND State0, PT := T#1s);
  SR0(S1 := NOT(VehSensor) AND TP0.Q, R := State2);
  State1 := SR0.Q1;
  VehGreenLight := NOT(State1 OR State2 OR State3);
  VehYellowLight := State1;
  VehYellowLight := NOT(State0 OR State2 OR State3);
  TON1(IN := State1, PT := T#3s);
  SR2(S1 := TON1.Q, R := State3);
  State2 := SR2.Q1;
  VehRedLight := State1 OR State2 OR State3;
  VehRedLight := NOT(State0 OR State1);
  PedGreenLight := State2;
  TON2(IN := State2, PT := T#15s);
  SR3(S1 := TON2.Q, R := State0);
  State3 := SR3.Q1;
  PedGreenLight := NOT(State0 OR State1 OR State3);
  PedRedLight := State0 OR State1 OR State3;
  PedRedLight := NOT(State2);
  TON0(IN := State3, PT := T#1s);
  SR1(S1 := State1, R := TON0.Q);
  State0 := NOT(SR1.Q1);
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : part3;
  END_RESOURCE
END_CONFIGURATION
