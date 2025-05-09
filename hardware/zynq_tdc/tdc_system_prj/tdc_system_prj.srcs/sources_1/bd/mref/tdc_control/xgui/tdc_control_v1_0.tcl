# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Brust_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Calib_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TimeOut_SIZE" -parent ${Page_0}


}

proc update_PARAM_VALUE.Brust_SIZE { PARAM_VALUE.Brust_SIZE } {
	# Procedure called to update Brust_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Brust_SIZE { PARAM_VALUE.Brust_SIZE } {
	# Procedure called to validate Brust_SIZE
	return true
}

proc update_PARAM_VALUE.Calib_SIZE { PARAM_VALUE.Calib_SIZE } {
	# Procedure called to update Calib_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Calib_SIZE { PARAM_VALUE.Calib_SIZE } {
	# Procedure called to validate Calib_SIZE
	return true
}

proc update_PARAM_VALUE.TimeOut_SIZE { PARAM_VALUE.TimeOut_SIZE } {
	# Procedure called to update TimeOut_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TimeOut_SIZE { PARAM_VALUE.TimeOut_SIZE } {
	# Procedure called to validate TimeOut_SIZE
	return true
}


proc update_MODELPARAM_VALUE.Calib_SIZE { MODELPARAM_VALUE.Calib_SIZE PARAM_VALUE.Calib_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Calib_SIZE}] ${MODELPARAM_VALUE.Calib_SIZE}
}

proc update_MODELPARAM_VALUE.Brust_SIZE { MODELPARAM_VALUE.Brust_SIZE PARAM_VALUE.Brust_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Brust_SIZE}] ${MODELPARAM_VALUE.Brust_SIZE}
}

proc update_MODELPARAM_VALUE.TimeOut_SIZE { MODELPARAM_VALUE.TimeOut_SIZE PARAM_VALUE.TimeOut_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TimeOut_SIZE}] ${MODELPARAM_VALUE.TimeOut_SIZE}
}

