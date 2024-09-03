/obj/item/organ/internal/evolved/var/mutation_risk = 0
/obj/item/organ/internal/evolved/var/abomination_threshold = 75

/obj/item/organ/internal/evolved/proc/evolve_organ()
    evolution_stage++
    evolution_progress = 0

    if(prob(mutation_risk))
        create_abomination()
    else
        switch(evolution_stage)
            if(2)
                add_tier_two_effect()
            if(3)
                add_tier_three_effect()

    update_organ_efficiency()
    mutation_risk += 10 // Increase risk with each evolution

/obj/item/organ/internal/evolved/proc/create_abomination()
    // Logic for creating an abomination
    var/abomination_type = pick("radioactive", "cancerous", "necrotic", "parasitic")
    switch(abomination_type)
        if("radioactive")
            create_radioactive_abomination()
        if("cancerous")
            create_cancerous_abomination()
        if("necrotic")
            create_necrotic_abomination()
        if("parasitic")
            create_parasitic_abomination()

/obj/item/organ/internal/evolved/proc/create_radioactive_abomination()
    name = "radioactive [initial(name)]"
    desc = "A highly radioactive organ that pulses with an eerie green glow."
    // Add radioactive effects and traits

/obj/item/organ/internal/evolved/proc/create_cancerous_abomination()
    name = "cancerous [initial(name)]"
    desc = "An organ riddled with aggressive, mutated cells."
    // Add cancerous growth effects

/obj/item/organ/internal/evolved/proc/create_necrotic_abomination()
    name = "necrotic [initial(name)]"
    desc = "A partially decayed organ that continues to function despite its condition."
    // Add necrosis and decay effects

/obj/item/organ/internal/evolved/proc/create_parasitic_abomination()
    name = "parasitic [initial(name)]"
    desc = "An organ infested with an unknown parasitic lifeform."
    // Add parasitic effects and potential spread to other organs
