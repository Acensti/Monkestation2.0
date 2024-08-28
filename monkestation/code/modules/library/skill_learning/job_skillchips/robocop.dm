/obj/item/skillchip/job/robocop
	name = "RB-COP 9000 skillchip"
	desc = "This biochip faintly smells of gunpowder, which is odd for something that is normally wedged inside a user's brain. Consult a dietician before use."
	skill_name = "Robocop Enhancements"
	skill_description = "Augments the user with advanced law enforcement capabilities, including enhanced strength and analytical abilities."
	skill_icon = "user-shield"
	activate_message = "<span class='notice'>You feel an overwhelming sense of justice and enhanced physical capabilities.</span>"
	deactivate_message = "<span class='notice'>Your enhanced law enforcement abilities fade away.</span>"
	/// The Robocop martial art given by the skillchip.
	var/datum/martial_art/robocopunch/style

/obj/item/skillchip/job/robocop/Initialize(mapload)
	. = ..()
	style = new

/obj/item/skillchip/job/robocop/on_activate(mob/living/carbon/user, silent = FALSE)
	. = ..()
	style.teach(user, make_temporary = FALSE)

/obj/item/skillchip/job/robocop/on_deactivate(mob/living/carbon/user, silent = FALSE)
	style.remove(user)
	return ..()
