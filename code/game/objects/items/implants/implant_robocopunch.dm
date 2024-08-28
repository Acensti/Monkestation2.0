/obj/item/implant/robocopunch
	name = "Robocopunch implant"
	desc = "Teaches you the arts of Robocopunch in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll1"
	var/datum/martial_art/robocopunch/style = new

/obj/item/implant/robocopunch/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Robocopunch Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Teaches even the clumsiest host the arts of Krav Maga."}
	return dat

/obj/item/implant/robocopunch/activate()
	. = ..()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(!H.mind)
		return
	if(H.mind.has_martialart(MARTIALART_KRAVMAGA))
		style.remove(H)
	else
		style.teach(H,1)

/obj/item/implanter/robocopunch
	name = "implanter (robocopunch)"
	imp_type = /obj/item/implant/robocopunch

/obj/item/implantcase/robocopunch
	name = "implant case - 'Robocopunch'"
	desc = "A glass case containing an implant that can teach the user the arts of Robocopunch."
	imp_type = /obj/item/implant/robocopunch
