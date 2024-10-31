# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk_100MHz]
set_property IOSTANDARD LVCMOS33 [get_ports clk_100MHz]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk_100MHz]

# LEDs
set_property PACKAGE_PIN U16 [get_ports {LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[0]}]
set_property PACKAGE_PIN E19 [get_ports {LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[1]}]
set_property PACKAGE_PIN U19 [get_ports {LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[2]}]
set_property PACKAGE_PIN V19 [get_ports {LED[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[3]}]
set_property PACKAGE_PIN W18 [get_ports {LED[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[4]}]
set_property PACKAGE_PIN U15 [get_ports {LED[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[5]}]
set_property PACKAGE_PIN U14 [get_ports {LED[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[6]}]
set_property PACKAGE_PIN V14 [get_ports {LED[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED[7]}]
#7 segment display
##7 Segment Display
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {seg[0]}]
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {seg[1]}]
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {seg[2]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {seg[3]}]
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {seg[4]}]
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {seg[5]}]
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {seg[6]}]


set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {an[0]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {an[1]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {an[2]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {an[3]}]

##Buttons
## btnL
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports btn]
## btnR
set_property PACKAGE_PIN T17 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
#Pmod Header JC
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports {JC[0]}];#Sch name = JC1
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports {brx}];#Sch name = JC2
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports tx]
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports {JC[3]}];#Sch name = JC4
#set_property -dict { PACKAGE_PIN L17   IOSTANDARD LVCMOS33 } [get_ports {JC[4]}];#Sch name = JC7
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports {JC[5]}];#Sch name = JC8
#set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports {JC[6]}];#Sch name = JC9
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports {JC[7]}];#Sch name = JC10

##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rx]
#set_property PACKAGE_PIN A18 [get_ports tx]
#set_property IOSTANDARD LVCMOS33 [get_ports tx]

#set_property IOSTANDARD LVCMOS33 [get_ports {read_data[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {read_data[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {read_data[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {read_data[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {read_data[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {read_data[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {read_data[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {read_data[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {write_data[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {write_data[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {write_data[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {write_data[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {write_data[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {write_data[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {write_data[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {write_data[0]}]
