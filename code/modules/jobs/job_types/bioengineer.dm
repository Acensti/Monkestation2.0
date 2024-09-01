/datum/job/bioengineer
	title = JOB_BIOENGINEER
	description = "Specializes in advanced organic manipulation and human enhancement."
	department_head = list(JOB_RESEARCH_DIRECTOR)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_RD
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BIOENGINEER"

	outfit = /datum/outfit/job/bioengineer
	plasmaman_outfit = /datum/outfit/plasmaman/bioengineering
	departments_list = list(
		/datum/job_department/science,
		)

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_BIOOENGINEER
	bounty_types = CIV_JOB_SCI

	mail_goodies = list(
		/obj/item/storage/box/monkeycubes = 10
	)

	family_heirlooms = list(/obj/item/clothing/under/shorts/purple)
	rpg_title = "Biomancer"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN


/datum/outfit/job/bioengineer
	name = "Biooengineer"
	jobtype = /datum/job/bioengineer

	id_trim = /datum/id_trim/job/bioengineer
	uniform = /obj/item/clothing/under/rank/rnd/geneticist // TODO: Create a new uniform for Bioengineers
	suit = /obj/item/clothing/suit/toggle/labcoat/genetics // TODO: Create a new labcoat for Bioengineers
	suit_store = /obj/item/flashlight/pen
	belt = /obj/item/modular_computer/pda/geneticist // TODO: Create a new PDA for Bioengineers
	ears = /obj/item/radio/headset/headset_medsci
	shoes = /obj/item/clothing/shoes/sneakers/white
	l_pocket = /obj/item/sequence_scanner // TODO: Change this to something more relevant for Bioengineers

	backpack = /obj/item/storage/backpack/bioengineering // TODO: Create a new backpack for Bioengineers
	satchel = /obj/item/storage/backpack/satchel/bio
	duffelbag = /obj/item/storage/backpack/duffelbag/bioengineer
