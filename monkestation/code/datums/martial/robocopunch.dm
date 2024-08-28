#define ROBOCOP_PUNCH_COMBO "HH"
#define ROBOCOP_STRONG_DISARM "HD"
#define RESTRAIN_COMBO "GG"
#define SCAN "scan_human_records"
#define LEG_SWEEP "leg_sweep"

/datum/martial_art/robocopunch
	name = "Robocop Combat System"
	id = MARTIALART_ROBOCOPUNCH
	help_verb = /mob/living/proc/robocop_help
	block_chance = 80
	smashes_tables = TRUE
	display_combos = TRUE
	var/mob/restraining_mob
	var/datum/action/leg_sweep/legsweep = new/datum/action/leg_sweep()
	var/datum/action/scan_human_records/scanhumanrecords = new/datum/action/scan_human_records()

/datum/martial_art/robocopunch/proc/leg_sweep(mob/living/attacker, mob/living/defender)
	if(defender.stat || defender.IsParalyzed())
		return FALSE
	defender.visible_message(span_warning("[attacker] leg sweeps [defender]!"), \
					span_userdanger("Your legs are sweeped by [attacker]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, attacker)
	to_chat(attacker, span_danger("You leg sweep [defender]!"))
	playsound(get_turf(attacker), 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
	defender.apply_damage(5, BRUTE, BODY_ZONE_CHEST)
	defender.Knockdown(6 SECONDS)
	log_combat(attacker, defender, "leg sweeped")
	return TRUE

/datum/action/scan_human_records
	name = "Scan Human Records"
	desc = "Scans a target for criminal record and contraband."
	button_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "scan"

/datum/action/scan_human_records/Trigger(trigger_flags)
	if(owner.incapacitated())
		to_chat(owner, span_warning("You can't use [name] while you're incapacitated."))
		return
	if (owner.mind.martial_art.streak == "scan_human_records")

		owner.visible_message(span_danger("[owner] eyes return to their former look."), "<b><i>Your next action is cleared.</i></b>")
		owner.mind.martial_art.streak = ""
	else
		owner.visible_message(span_danger("[owner] eyes starts to shine!"), "<b><i>Your next action will be a human scan.</i></b>")
		owner.mind.martial_art.streak = "scan_human_records"

/datum/martial_art/robocopunch/proc/scan_human_records(mob/living/attacker, mob/living/defender)
	attacker.visible_message(span_notice("[attacker] scans [defender] with advanced sensors."), \
					span_notice("You scan [defender] with your advanced sensors."), null, COMBAT_MESSAGE_RANGE, defender)
	to_chat(defender, span_userdanger("[attacker] is scanning you with advanced sensors!"))
	if(do_after(attacker, 3 SECONDS, defender))
		to_chat(attacker, span_notice("Scan complete. Analyzing [defender]..."))
		if(ishuman(defender))
			var/mob/living/carbon/human/H = defender
			H.list_criminal_record(defender)
			to_chat(attacker, span_notice("Contraband detected: [H.list_contraband(defender) ? "Yes" : "No"]"))
		else
			to_chat(attacker, span_notice("Unable to analyze non-human target."))
	log_combat(attacker, defender, "analyzed (Robocop)")
	return TRUE

/datum/martial_art/robocopunch/harm_act(mob/living/attacker, mob/living/defender)
	check_streak(attacker, defender)
	add_to_streak("H", defender)
	if(check_streak(attacker, defender))
		return TRUE
	..()

/datum/martial_art/robocopunch/grab_act(mob/living/attacker, mob/living/defender)
	check_streak(attacker, defender)
	add_to_streak("G", defender)
	if(check_streak(attacker, defender))
		return TRUE
	..()

/datum/martial_art/robocopunch/disarm_act(mob/living/attacker, mob/living/defender)
	check_streak(attacker, defender)
	add_to_streak("D", defender)
	if(check_streak(attacker, defender))
		return TRUE
	..()

/datum/martial_art/robocopunch/reset_streak(mob/living/new_target)
	if(new_target && new_target != restraining_mob)
		restraining_mob = null
	return ..()

/datum/martial_art/robocopunch/proc/check_streak(mob/living/attacker, mob/living/defender)
	to_chat(attacker, span_notice("streak is [streak]"))
	if(findtext(streak, ROBOCOP_PUNCH_COMBO))
		reset_streak()
		return robocop_punch(attacker, defender)
	if(findtext(streak, RESTRAIN_COMBO))
		reset_streak()
		return restrain(attacker, defender)
	if(findtext(streak, LEG_SWEEP))
		reset_streak()
		to_chat(attacker, span_notice("did a leg sweep"))
		return leg_sweep(attacker, defender)
	if(findtext(streak, SCAN))
		reset_streak()
		to_chat(attacker, span_notice("did human scan"))
		return scan_human_records(attacker, defender)
	return FALSE

/datum/martial_art/robocopunch/proc/robocop_punch(mob/living/attacker, mob/living/defender)
	if(!can_use(attacker))
		return FALSE
	defender.visible_message(span_danger("[attacker] delivers a powerful punch to [defender]!"), \
					span_userdanger("You're hit with a powerful punch by [attacker]!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, attacker)
	to_chat(attacker, span_danger("You deliver a powerful punch to [defender]!"))
	playsound(get_turf(defender), 'sound/weapons/punch4.ogg', 50, TRUE, -1)
	defender.apply_damage(15, BRUTE)
	defender.Knockdown(10)
	log_combat(attacker, defender, "robocop punched")
	return TRUE

/datum/martial_art/robocopunch/proc/restrain(mob/living/attacker, mob/living/defender)
	if(restraining_mob)
		return
	if(!can_use(attacker))
		return FALSE
	if(!defender.stat)
		log_combat(attacker, defender, "restrained (Robocopunch)")
		defender.visible_message(span_warning("[attacker] locks [defender] into a restraining position!"), \
						span_userdanger("You're locked into a restraining position by [attacker]!"), span_hear("You hear shuffling and a muffled groan!"), null, attacker)
		to_chat(attacker, span_danger("You lock [defender] into a restraining position!"))
		defender.stamina.adjust(-20)
		defender.Stun(10 SECONDS)
		restraining_mob = defender
		addtimer(VARSET_CALLBACK(src, restraining_mob, null), 50, TIMER_UNIQUE)
		return TRUE

/mob/living/proc/robocop_help()
	set name = "Remember Robocop Training"
	set desc = "Remember the basics of Robocop combat."
	set category = "Robocop"

	to_chat(usr, "<b><i>You recall your Robocop combat training...</i></b>")
	to_chat(usr, span_notice("Robocop Punch"))
	to_chat(usr, span_notice("\tDelivers a powerful punch that can knock down opponents."))
	to_chat(usr, span_notice("\tPerform by striking harmfully twice in a row."))
	to_chat(usr, span_notice("Robocop Analyze"))
	to_chat(usr, span_notice("\tScans a target for criminal record and contraband."))
	to_chat(usr, span_notice("\tPerform by striking harmfully then disarming."))

/mob/living/carbon/human/proc/list_criminal_record(var/datum/record/crew/target)
	//var/datum/record/crew/target = find_record(target.real_name)
	if(!target)
		to_chat(src, span_warning("No criminal record found for [target]."))
		return

	var/list/crimes = target.crimes
	var/list/citations = target.citations

	to_chat(src, span_notice("<b>Criminal Record for [target]:</b>"))
	to_chat(src, span_notice("Wanted Status: [target.wanted_status]"))

	if(length(crimes))
		to_chat(src, span_notice("<b>Crimes:</b>"))
		for(var/datum/crime/crime in crimes)
			if(!crime.valid)
				continue
			to_chat(src, span_notice("- [crime.name]: [crime.details] (Recorded by [crime.author] at [crime.time])"))
	else
		to_chat(src, span_notice("No crimes on record."))

	if(length(citations))
		to_chat(src, span_notice("<b>Citations:</b>"))
		for(var/datum/crime/citation/citation in citations)
			if(!citation.valid)
				continue
			to_chat(src, span_notice("- [citation.name]: [citation.details] (Fine: [citation.fine]cr, Recorded by [citation.author] at [citation.time])"))
	else
		to_chat(src, span_notice("No citations on record."))

	if(target.security_note)
		to_chat(src, span_notice("<b>Security Note:</b> [target.security_note]"))

/mob/living/carbon/human/proc/list_contraband()
	return prob(20)

/datum/martial_art/robocopunch/teach(mob/living/owner, make_temporary=FALSE)
	. = ..()
	if(..())
		to_chat(owner, span_userdanger("You know the arts of [name]!"))
		to_chat(owner, span_danger("Place your cursor over a move at the top of the screen to see what it does."))
		legsweep.Grant(owner)
		scanhumanrecords.Grant(owner)

/datum/martial_art/robocopunch/on_remove(mob/living/owner)
	to_chat(owner, span_userdanger("You suddenly forget the arts of [name]..."))
	legsweep.Remove(owner)
	scanhumanrecords.Remove(owner)
	. = ..()

#undef ROBOCOP_PUNCH_COMBO
#undef ROBOCOP_STRONG_DISARM
#undef RESTRAIN_COMBO
#undef SCAN
#undef LEG_SWEEP
