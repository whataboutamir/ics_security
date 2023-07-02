PROGRAM part5b
  VAR
    MinLvlSensor AT %IX0.0 : BOOL;
    LowLvlSensor AT %IX0.1 : BOOL;
    MedLvlSensor AT %IX0.2 : BOOL;
    HighLvlSensor AT %IX0.3 : BOOL;
    InValve1_A AT %QX0.0 : BOOL;
    InValve2_B AT %QX0.1 : BOOL;
    InValve3_C AT %QX0.2 : BOOL;
    Blade AT %QX0.3 : BOOL;
    OutValve AT %QX0.4 : BOOL;
  END_VAR
  VAR
    State0 : BOOL := True;
    State1 : BOOL;
    State2 : BOOL;
    State3 : BOOL;
    State4 : BOOL;
    State5 : BOOL;
    State6 : BOOL;
    SR0 : SR;
    SR1 : SR;
    SR2 : SR;
    SR3 : SR;
    TON0 : TON;
    SR4 : SR;
    SR5 : SR;
    SR6 : SR;
    TON1 : TON;
    Trigger : BOOL;
    CTU0 : CTU;
    SR7 : SR;
    R_TRIG1 : R_TRIG;
  END_VAR

  InValve1_A := State1;
  SR0(S1 := State0, R := State2);
  State1 := SR0.Q1;
  R_TRIG1(CLK := SR0.Q1);
  CTU0(CU := R_TRIG1.Q, PV := 4);
  SR7(S1 := CTU0.Q);
  Trigger := SR7.Q1;
  InValve1_A := NOT(State0 OR State2 OR State3 OR State4 OR State5 OR State6);
  SR1(S1 := LowLvlSensor AND State1, R := State3);
  State2 := SR1.Q1;
  InValve2_B := State1 OR State2 OR State3;
  InValve2_B := NOT(State0 OR State4 OR State5 OR State6);
  SR2(S1 := MedLvlSensor AND State2, R := State4);
  State3 := SR2.Q1;
  InValve3_C := State3;
  InValve3_C := NOT(State0 OR State1 OR State2 OR State4 OR State5 OR State6);
  SR3(S1 := HighLvlSensor AND State3, R := State5);
  State4 := SR3.Q1;
  OutValve := State5 OR State6;
  OutValve := NOT(State0 OR State1 OR State2 OR State3 OR State4);
  TON0(IN := State4, PT := T#5s);
  SR4(S1 := TON0.Q, R := State6);
  State5 := SR4.Q1;
  Blade := NOT(Trigger) AND State4 OR NOT(Trigger) AND State5 OR NOT(Trigger) AND State6 OR Trigger AND State1 OR Trigger AND State2 OR Trigger AND State3 OR Trigger AND State0;
  Blade := NOT(NOT(Trigger) AND State0 OR NOT(Trigger) AND State1 OR NOT(Trigger) AND State2 OR NOT(Trigger) AND State3 OR NOT(Trigger) AND State6 OR Trigger AND State4 OR Trigger AND State5);
  SR5(S1 := NOT(MinLvlSensor) AND State5, R := State0);
  State6 := SR5.Q1;
  TON1(IN := State6, PT := T#3s);
  SR6(S1 := TON1.Q, R := State1);
  State0 := SR6.Q1;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : part5b;
  END_RESOURCE
END_CONFIGURATION
