class patrolOps
{
	tag = "PatrolOps";
	class patrolGeneration 
	{
		file = "PatrolOps\patrol generation";
		class initpatrol 				{};
		class generateRouteMarkers 		{};
		class generateLocations 		{};
		class patrolCleanUp 			{};

	};
	class effects
	{
		file = "PatrolOps\effects";
		class unconscious 				{};

	};
	class Functions
	{
		file = "PatrolOps\functions";
		class getRoadInfo 				{};
		class findSideLocations 		{};
		class debugMarkers 				{};
		class vehicleInventory 			{};
		class clearVehicleCargo 		{};

	};
	class objectives
	{
		file = "PatrolOps\objectives";
		class generateObjective 		{};

	};
	class spawning
	{
		file = "PatrolOps\spawning";
		class playerVehicleSpawn 		{};
		
	};
};