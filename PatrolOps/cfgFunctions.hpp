class patrolOps
{
	tag = "PatrolOps";
	class patrolGeneration 
	{
		file = "PatrolOps\patrol generation";
		class initpatrol 					{};
		class generatePatrol				{};
		class generateRouteMarkers 			{};
		class generateLocations 			{};
		class patrolCleanUp 				{};
		class findSideLocations 			{};
		class routeCheck					{};

	};
	class IEDs
	{
		file = "PatrolOps\IEDs";
		class findPOILocations 				{};
		class selectIEDs					{};
		class getNumberofIEDs				{};
		class selectIEDType					{};
		class processIEDLocations			{};	
		class configureDirtRoadIED			{};
		class configurePavedRoadIED			{};
		class dig							{};
		class spawnPavedRoadIED				{};
		class spawnDirtRoadIED				{};

	};
	class effects
	{
		file = "PatrolOps\effects";
		class unconscious 					{};
		class earRinging					{};
		class blurEffects					{};
		class explosionEffects				{};
		class smokeEffects					{};
		class rockEffects					{};
		class shockWaveEffects				{};
		class colourSmokeEffect				{};

	};
	class Functions
	{
		file = "PatrolOps\functions";
		class getRoadInfo 					{};
		class debugMarkers 					{};
		class vehicleInventory 				{};
		class clearVehicleCargo 			{};
		class randomDifficulty 				{};
		class findBuildingPos				{};
		class findRandomBuilding			{};
		class setMissionTime 				{};
		class movePlayers					{};
		class getObjectSize 				{};
		class timeCycle						{};
		class revealMines					{};
		class checkOverlap					{};

	};
	class objectives
	{
		file = "PatrolOps\objectives";
		class generateObjective 			{};
		class createObjectiveMarker			{};
		class iedFactory					{};
		class manHunt						{};
		class vehicleRecovery				{};
		class weaponsCache					{};	

	};
	class units
	{
		file = "PatrolOps\units";
		class unitReDress 					{};
		class createInsurgentSquad			{};
		
	};
	class spawning
	{
		file = "PatrolOps\spawning";
		class playerVehicleSpawn 			{};
		
	};
	class ambushes
	{
		file = "PatrolOps\ambushes";
		class iedAmbushes					{};
		class townAmbushes					{};
		class roadAmbushes					{};

	};
};