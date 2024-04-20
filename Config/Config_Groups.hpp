class Dynamic_Groups { //format: {"Group Name",{"Group","Roles","Matching","Role","Configs"},"Conditions for the group to be shown"}
	faction_name = "TASKFORCE NZF";
	group_setup[] = {

		{"BRIMSTONE 6-4",{"squadlead","rifleman","eod","eod"},"true"},
		{"HAVOC 1-1",{"squadlead","teamlead","medic","machinegunner","assistantMachinegunner","teamlead","genadier","rifleman","rifleman"},"true"},
		{"HAVOC 1-2",{"squadlead","teamlead","medic","machinegunner","assistantMachinegunner","teamlead","genadier","rifleman","rifleman"},"count playableUnits > 12"}
		
	};
};

#include "Config_Roles.hpp"