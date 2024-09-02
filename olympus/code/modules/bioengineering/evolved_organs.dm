/obj/item/organ/internal/evolved
    name = "evolved organ"
    desc = "An organ that has been evolved beyond its natural capabilities."
    var/evolution_stage = 1
    var/max_evolution_stage = 3
    var/list/evolution_effects = list()

/obj/item/organ/internal/evolved/heart
    name = "evolved heart"
    desc = "An evolved heart with enhanced capabilities."
    icon_state = "heart-evolved"
    base_icon_state = "heart-evolved"

/obj/item/organ/internal/evolved/heart/on_life(delta_time, times_fired)
    . = ..()
    var/mob/living/carbon/human/H = owner
    if(istype(H))
        for(var/effect in evolution_effects)
            switch(effect)
                if("adrenaline_boost")
                    if(H.health < 50)
                        H.adjustStaminaLoss(-5 * delta_time)
                        H.adjustOxyLoss(-2 * delta_time)
                if("stamina_regeneration")
                    H.adjustStaminaLoss(-3 * delta_time)

/obj/item/organ/internal/evolved/liver
    name = "evolved liver"
    desc = "An evolved liver with enhanced filtration capabilities."
    icon_state = "liver-evolved"
    base_icon_state = "liver-evolved"

/obj/item/organ/internal/evolved/liver/on_life(delta_time, times_fired)
    . = ..()
    var/mob/living/carbon/human/H = owner
    if(istype(H))
        for(var/effect in evolution_effects)
            switch(effect)
                if("toxin_filter")
                    H.adjustToxLoss(-2 * delta_time)
                if("alcohol_resistance")
                    H.drunkenness = max(0, H.drunkenness - 2 * delta_time)

/obj/item/organ/internal/evolved/lungs
    name = "evolved lungs"
    desc = "A pair of evolved lungs with enhanced respiratory capabilities."
    icon_state = "lungs-evolved"
    base_icon_state = "lungs-evolved"

/obj/item/organ/internal/evolved/lungs/on_life(delta_time, times_fired)
    . = ..()
    var/mob/living/carbon/human/H = owner
    if(istype(H))
        for(var/effect in evolution_effects)
            switch(effect)
                if("oxygen_efficiency")
                    H.adjustOxyLoss(-3 * delta_time)
                if("toxin_resistance")
                    H.adjustToxLoss(-1 * delta_time)
