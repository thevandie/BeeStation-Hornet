/datum/species/squid
    name = "Squidperson"
    id = "squid"
    default_color = "b8dfda"
    species_traits = list(MUTCOLORS,EYECOLOR,TRAIT_EASYDISMEMBER)
    inherent_traits = list(TRAIT_NOSLIPALL)
    default_features = list("mcolor" = "FFF") // bald
    speedmod = 0.3
    burnmod = 1.5
    heatmod = 1.4
    coldmod = 1.5
    punchdamagehigh = 7 // Lower max damage in melee. It's just a tentacle
    changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | SLIME_EXTRACT
    attack_verb = list("whipped", "lashed", "disciplined")
    attack_sound = 'sound/weapons/whip.ogg'
    miss_sound = 'sound/weapons/etherealmiss.ogg'
    grab_sound = 'sound/weapons/whipgrab.ogg'
    deathsound = 'sound/voice/hiss1.ogg'
    use_skintones = 0
    no_equip = list(SLOT_SHOES)
    skinned_type = /obj/item/stack/sheet/animalhide/human
    toxic_food = FRIED

    var/current_color
    var/datum/action/innate/squid_change/color

/mob/living/carbon/human/species/squid
    race = /datum/species/squid

/datum/species/squid/qualifies_for_rank(rank, list/features)
    return TRUE

/datum/species/squid/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_squid_name(genderToFind = gender)

	var/randname = squid_name(gender)

	if(lastname)
		randname += " [lastname]"

	return randname

/proc/random_unique_squid_name(attempts_to_find_unique_name=10, genderToFind)
    for(var/i in 1 to attempts_to_find_unique_name)
        . = capitalize(squid_name(genderToFind))
        if(!findname(.))
            break

/datum/species/squid/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	H.grant_language(/datum/language/rlyehian)

/datum/species/squid/spec_updatehealth(mob/living/carbon/human/H)
	.=..()
	if(H.stat != DEAD )
		fixed_mut_color = copytext(current_color, 2)
	else
		fixed_mut_color = rgb(128,128,128)
	H.update_body()

/datum/action/innate/squid_change
	name = "Color Change"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/animal.dmi'
	button_icon_state = "squid"

/datum/action/innate/squid_change/Activate()
	var/mob/living/carbon/human/H = owner
	H.dna.features["mcolor"] = rgb(rand(128,255),rand(128,255),rand(128,255))
	H.update_body()
