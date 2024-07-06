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
		class routeCheck				{};

	};
	class IEDs
	{
		file = "PatrolOps\IEDs";
		class findIEDLocations 			{};

	};
	class effects
	{
		file = "PatrolOps\effects";
		class unconscious 				{};
		class earRinging				{};
		class blurEffects				{};
		class explosionEffects			{};
		class smokeEffects				{};
		class rockEffects				{};
		class shockWaveEffects			{};
		class colourSmokeEffect			{};

	};
	class Functions
	{
		file = "PatrolOps\functions";
		class getRoadInfo 				{};
		class findSideLocations 		{};
		class debugMarkers 				{};
		class vehicleInventory 			{};
		class clearVehicleCargo 		{};
		class randomDifficulty 			{};
		class findBuildingPos			{};
		class findRandomBuilding		{};
		class setMissionTime 			{};
		class movePlayers					{};

	};
	class objectives
	{
		file = "PatrolOps\objectives";
		class generateObjective 		{};
		class createObjectiveMarker		{};
		class iedFactory				{};
		class manHunt					{};
		class vehicleRecovery			{};
		class weaponsCache				{};	

	};
	class units
	{
		file = "PatrolOps\units";
		class unitReDress 				{};
		class createInsurgentSquad		{};
		
	};
	class spawning
	{
		file = "PatrolOps\spawning";
		class playerVehicleSpawn 		{};
		
	};
};