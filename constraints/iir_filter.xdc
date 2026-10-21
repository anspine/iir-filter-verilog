## Clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk}]

## Reset
set_property -dict { PACKAGE_PIN D9 IOSTANDARD LVCMOS33 } [get_ports {rst}]

## JA1-JA4: mirrored switch inputs
set_property -dict { PACKAGE_PIN G13 IOSTANDARD LVCMOS33 } [get_ports {z[0]}]
set_property -dict { PACKAGE_PIN B11 IOSTANDARD LVCMOS33 } [get_ports {z[1]}]
set_property -dict { PACKAGE_PIN A11 IOSTANDARD LVCMOS33 } [get_ports {z[2]}]
set_property -dict { PACKAGE_PIN D12 IOSTANDARD LVCMOS33 } [get_ports {z[3]}]

## JA7-JA10: IIR output
set_property -dict { PACKAGE_PIN D13 IOSTANDARD LVCMOS33 } [get_ports {y_state[0]}]
set_property -dict { PACKAGE_PIN B18 IOSTANDARD LVCMOS33 } [get_ports {y_state[1]}]
set_property -dict { PACKAGE_PIN A18 IOSTANDARD LVCMOS33 } [get_ports {y_state[2]}]
set_property -dict { PACKAGE_PIN K16 IOSTANDARD LVCMOS33 } [get_ports {y_state[3]}]

## Switch inputs
set_property -dict { PACKAGE_PIN A8 IOSTANDARD LVCMOS33 } [get_ports {x[0]}]
set_property -dict { PACKAGE_PIN C11 IOSTANDARD LVCMOS33 } [get_ports {x[1]}]
set_property -dict { PACKAGE_PIN C10 IOSTANDARD LVCMOS33 } [get_ports {x[2]}]
set_property -dict { PACKAGE_PIN A10 IOSTANDARD LVCMOS33 } [get_ports {x[3]}]
