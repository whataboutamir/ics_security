PROGRAM part4a
  VAR
    Tank1_LowLvlSensor AT %IX0.0 : BOOL;
    Tank1_MedLvlSensor AT %IX0.1 : BOOL;
    Tank1_HighLvlSensor AT %IX0.2 : BOOL;
    Tank2_LowLvlSensor AT %IX0.3 : BOOL;
    Tank2_MedLvlSensor AT %IX0.4 : BOOL;
    Tank2_HighLvlSensor AT %IX0.5 : BOOL;
    Tank3_LowLvlSensor AT %IX0.6 : BOOL;
    Tank3_MedLvlSensor AT %IX0.7 : BOOL;
    Tank3_HighLvlSensor AT %IX1.0 : BOOL;
    Tank4_LowLvlSensor AT %IX1.1 : BOOL;
    Tank4_MedLvlSensor AT %IX1.2 : BOOL;
    Tank4_HighLvlSensor AT %IX1.3 : BOOL;
    Tank1_OutValve AT %QX0.0 : BOOL;
    Tank2_OutValve AT %QX0.1 : BOOL;
    Tank3_OutValve AT %QX0.2 : BOOL;
    Tank4_OutValve AT %QX0.3 : BOOL;
  END_VAR

  Tank1_OutValve := NOT(NOT(Tank1_MedLvlSensor) AND Tank1_LowLvlSensor OR NOT(Tank1_LowLvlSensor));
  Tank1_OutValve := Tank1_MedLvlSensor;
  Tank2_OutValve := NOT(NOT(Tank2_MedLvlSensor) AND Tank2_LowLvlSensor OR NOT(Tank2_LowLvlSensor));
  Tank2_OutValve := Tank2_MedLvlSensor;
  Tank3_OutValve := NOT(NOT(Tank3_MedLvlSensor) AND Tank3_LowLvlSensor OR NOT(Tank3_LowLvlSensor));
  Tank3_OutValve := Tank3_MedLvlSensor;
  Tank4_OutValve := NOT(NOT(Tank4_MedLvlSensor) AND Tank4_LowLvlSensor OR NOT(Tank4_LowLvlSensor));
  Tank4_OutValve := Tank4_MedLvlSensor;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : part4a;
  END_RESOURCE
END_CONFIGURATION
