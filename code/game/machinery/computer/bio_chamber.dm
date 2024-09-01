/obj/machinery/computer/bio_chamber
	name = "Bio Chamber"
	desc = "A machine for growing organs, or abominations."
	icon_screen = "dna" // TODO: Replace with a new icon
	icon_keyboard = "med_key" // TODO: Replace with a new icon
	density = TRUE
	circuit = /obj/item/circuitboard/computer/bio_chamber

	light_color = LIGHT_COLOR_FLARE

	/// Link to the techweb's stored research. Used to retrieve stored mutations
	var/datum/techweb/stored_research
	/// List of all organs stored in the DNA Console
	var/list/stored_organs = list()

	/// State of tgui view, i.e. which tab is currently active
	var/list/list/tgui_view_state = list()


/obj/machinery/computer/bio_chamber/attackby(obj/item/item, mob/user, params)
	// Store organs in the console
	if (istype(item, /obj/item/organ))
		item.forceMove(src)
		stored_organs += item
		to_chat(user, span_notice("You insert [item]."))
		return
	return ..()

/obj/machinery/computer/bio_chamber/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	// Most of ui_interact is spent setting variables for passing to the tgui
	//  interface.
	// We can also do some general state processing here too as it's a good
	//  indication that a player is using the console.

	// Attempt to update tgui ui, open and update if needed.
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BioChamber")
		ui.open()

/obj/machinery/computer/bio_chamber/ui_data(mob/user)
	var/list/data = list()

	data["view"] = tgui_view_state
	data["storage"] = list()

	return data

/obj/machinery/computer/bio_chamber/ui_act(action, list/params)
	var/static/list/gene_letters = list("A", "T", "C", "G");
	var/static/gene_letter_count = length(gene_letters)

	. = ..()
	if(.)
		return

	. = TRUE

	add_fingerprint(usr)
	usr.set_machine(src)

	switch(action)
		// Sets a new tgui view state
		// ---------------------------------------------------------------------- //
		// params["id"] - Key for the state to set
		// params[...] - Every other element is used to set state variables
		if("set_view")
			for (var/key in params)
				if(key == "src")
					continue
				tgui_view_state[key] = params[key]
			return TRUE

	return FALSE


/**
 * Ejects the organ from the console.
	*
	* Will insert into the user's hand if possible, otherwise will drop it at the
	* console's location.
	*
	* Arguments:
 * * user - The mob that is attempting to eject the organ.
 */
/obj/machinery/computer/bio_chamber/proc/eject_organ(mob/user, obj/item/organ)
	to_chat(user, span_notice("You remove [organ] from [src]."))

	// If the organ shouldn't pop into the user's hand for any reason, drop it on the console instead.
	if(!istype(user) || !Adjacent(user) || !user.put_in_active_hand(organ))
		organ.forceMove(drop_location())

/**
 * Sets the default state for the tgui interface.
 */
/obj/machinery/computer/scan_consolenew/proc/set_default_state()
	tgui_view_state["consoleMode"] = "storage"
	tgui_view_state["storageMode"] = "console"
	tgui_view_state["storageConsSubMode"] = "mutations"
	tgui_view_state["storageDiskSubMode"] = "mutations"
