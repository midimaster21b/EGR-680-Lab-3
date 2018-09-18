# Clock signal (125 MHz)
set_property -dict { PACKAGE_PIN H16 IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clk }];

# Buttons
set_property -dict { PACKAGE_PIN L19 IOSTANDARD LVCMOS33 } [get_ports { rst }];
set_property -dict { PACKAGE_PIN L20 IOSTANDARD LVCMOS33 } [get_ports { yogurt }];
set_property -dict { PACKAGE_PIN D20 IOSTANDARD LVCMOS33 } [get_ports { apple }];
set_property -dict { PACKAGE_PIN D19 IOSTANDARD LVCMOS33 } [get_ports { gum }];

# Switches
set_property -dict { PACKAGE_PIN M19 IOSTANDARD LVCMOS33 } [get_ports { dime }];
set_property -dict { PACKAGE_PIN M20 IOSTANDARD LVCMOS33 } [get_ports { nickel }];

# PmodA (Seven Segment Display)
set_property -dict { PACKAGE_PIN Y18 IOSTANDARD LVCMOS33 } [get_ports { seven_segment[6] }];
set_property -dict { PACKAGE_PIN Y19 IOSTANDARD LVCMOS33 } [get_ports { seven_segment[5] }];
set_property -dict { PACKAGE_PIN Y16 IOSTANDARD LVCMOS33 } [get_ports { seven_segment[4] }];
set_property -dict { PACKAGE_PIN Y17 IOSTANDARD LVCMOS33 } [get_ports { seven_segment[3] }];
set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports { seven_segment[2] }];
set_property -dict { PACKAGE_PIN U19 IOSTANDARD LVCMOS33 } [get_ports { seven_segment[1] }];
set_property -dict { PACKAGE_PIN W18 IOSTANDARD LVCMOS33 } [get_ports { seven_segment[0] }];
set_property -dict { PACKAGE_PIN W19 IOSTANDARD LVCMOS33 } [get_ports { seven_segment_digit }];

# Onboard LED's
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports { change_output[3] }];
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports { change_output[2] }];
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { change_output[1] }];
set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports { change_output[0] }];

