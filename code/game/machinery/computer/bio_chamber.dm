/obj/machinery/computer/bio_chamber
	name = "Bio Chamber"
	desc = "A machine for growing organs, or abominations."
	icon_screen = "dna"
	icon_keyboard = "med_key"
	density = TRUE
	circuit = /obj/item/circuitboard/computer/bio_chamber

	light_color = LIGHT_COLOR_FLARE

	var/datum/techweb/stored_research
	var/list/stored_organs = list()
	var/list/list/tgui_view_state = list()
	var/list/mixing_chamber = list()
	var/obj/item/organ/active_organ
	var/max_reagents = 3
	var/mixing_potency = 0
	var/radiation_level = 0

/obj/machinery/computer/bio_chamber/Initialize()
	. = ..()
	set_default_state()

/obj/machinery/computer/bio_chamber/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/organ))
		insert_organ(item, user)
		return
	if(istype(item, /obj/item/reagent_containers))
		add_reagent(item, user)
		return
	return ..()

/obj/machinery/computer/bio_chamber/proc/insert_organ(obj/item/organ/O, mob/user)
	if(active_organ)
		to_chat(user, span_warning("There's already an organ in the chamber!"))
		return
	O.forceMove(src)
	active_organ = O
	to_chat(user, span_notice("You insert [O] into [src]."))

/obj/machinery/computer/bio_chamber/proc/add_reagent(obj/item/reagent_containers/RC, mob/user)
	if(length(mixing_chamber) >= max_reagents)
		to_chat(user, span_warning("The mixing chamber is full!"))
		return
	if(!RC.reagents.total_volume)
		to_chat(user, span_warning("[RC] is empty!"))
		return
	RC.reagents.trans_to(src, RC.reagents.total_volume)
	mixing_chamber += RC.reagents.reagent_list
	to_chat(user, span_notice("You add [RC] to the mixing chamber."))
	update_mixing_potency()

/obj/machinery/computer/bio_chamber/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BioChamber")
		ui.open()

/obj/machinery/computer/bio_chamber/ui_data(mob/user)
	. = ..()
	var/list/data = list()
	data["view"] = tgui_view_state
	data["active_organ"] = active_organ ? list(
		"name" = active_organ.name,
		"desc" = active_organ.desc,
		"radiation_level" = radiation_level
	) : null
	data["mixing_chamber"] = mixing_chamber
	data["mixing_potency"] = mixing_potency
	return data

/obj/machinery/computer/bio_chamber/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	. = TRUE
	switch(action)
		if("set_view")
			for (var/key in params)
				if(key == "src")
					continue
				tgui_view_state[key] = params[key]
		if("start_irradiation")
			irradiate_organ()
		if("eject_organ")
			eject_organ(usr)
		if("clear_mixing_chamber")
			mixing_chamber.Cut()
			update_mixing_potency()
	return FALSE

/obj/machinery/computer/bio_chamber/proc/eject_organ(mob/user)
	if(!active_organ)
		to_chat(user, span_warning("There's no organ in the chamber!"))
		return
	to_chat(user, span_notice("You remove [active_organ] from [src]."))
	if(!user.put_in_active_hand(active_organ))
		active_organ.forceMove(drop_location())
	active_organ = null

/obj/machinery/computer/bio_chamber/proc/set_default_state()
	tgui_view_state["consoleMode"] = "storage"
	tgui_view_state["storageMode"] = "console"

/obj/machinery/computer/bio_chamber/proc/update_mixing_potency()
	mixing_potency = 0
	for(var/datum/reagent/R in mixing_chamber)
		mixing_potency += R.volume * get_reagent_potency(R)

/obj/machinery/computer/bio_chamber/proc/get_reagent_potency(datum/reagent/R)
	switch(R.type)
		if(/datum/reagent/uranium)
			return 2
		if(/datum/reagent/toxin/plasma)
			return 3
		if(/datum/reagent/consumable/nutriment)
			return 1
	return 0.5

/obj/machinery/computer/bio_chamber/proc/irradiate_organ()
	if(!active_organ || !length(mixing_chamber))
		return
	for(var/datum/reagent/R in mixing_chamber)
		if(istype(R, /datum/reagent/uranium))
			radiation_level += R.volume
	if(radiation_level > 0)
		radiation_level += radiation_level
		to_chat(usr, span_notice("The [active_organ] is exposed to radiation."))
		check_mutation()

/obj/machinery/computer/bio_chamber/proc/check_mutation()
	if(!active_organ)
		return
	if(radiation_level > 50)
		mutate_organ()

/obj/machinery/computer/bio_chamber/proc/mutate_organ()
	if(istype(active_organ, /obj/item/organ/internal/heart))
		active_organ.name = "irradiated heart"
		active_organ.desc = "A heart that pulses with an eerie green glow."
		// Add effects to the heart
	// Add more organ types
