class DEKComboSpecial extends Combo;

#exec  AUDIO IMPORT NAME="PlayerComboSound" FILE="Sounds\PlayerComboSound.WAV" GROUP="ComboSounds"

var GiveItemsInv GInv;

function StartEffect(xPawn P)
{
	local ComboAbilityInv CAInv;
	local Controller C;
	
	if (GInv == None)
	{
		if (Pawn(Owner) != None)
		{
			GInv = class'DEKRPG208AA.GiveItemsInv'.static.GetGiveItemsInv(Pawn(Owner).Controller);
		}
	}
	
	if (Pawn(Owner) != None)
	{
		if (GInv != None && GInv.NumCombos > 0)
		{
			//GInv.Combo points to the first ComboAbilityInv in list. GInv.Combo never changes
			//Move CAInv, the temp pointer, along the list
			for(CAInv = GInv.Combo; CAInv != None; CAInv = CAInv.ComboAbilityInv)
			{
				if (CAInv != None)
				{
					CAInv.DoEffect();
				}
			}
			GInv.NumCombos--;
			if (GInv.NumCombos < 0)
				GInv.NumCombos = 0;
			for ( C = Level.ControllerList; C != None; C = C.NextController )
				if (C != None && C.IsA('PlayerController') && P != None && P.Controller != None && C.SameTeamAs(P.Controller) && C != P.Controller)
					PlayerController(C).ClientPlaySound(Sound'BotsCombos208AA.PlayerComboSound');
		}
		else
			Destroy();
			//Send a message to a player saying they don't have any combos to use
	}
	Destroy();
}

function StopEffect(xPawn P)
{
}

defaultproperties
{
	ExecMessage=""
	keys(0)=1
	keys(1)=1
	keys(2)=2
	keys(3)=2
	AdrenalineCost=1.000000
	Duration=1.00
	ActivateSound=Sound'BotsCombos208AA.PlayerComboSound'
}
