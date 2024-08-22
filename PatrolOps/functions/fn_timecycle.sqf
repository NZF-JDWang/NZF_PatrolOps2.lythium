if (!isServer) exitWith {};

while {true} do
{
	if (daytime >= 21 || daytime < 4) then
	{
		setTimeMultiplier 4
	}
	else
	{
		setTimeMultiplier 2
	};
	uiSleep 30;
};