/datum/job/robocop
	title = JOB_ROBOCOP
	description = "Protect company assets, enforce the law, and protect the crew from harm."
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_HEAD_OF_SECURITY)
	faction = FACTION_STATION
	total_positions = 1 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	spawn_positions = 1 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	supervisors = "the Head of Security"
	minimal_player_age = 7
	exp_requirements = 450
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SECURITY
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "ROBOCOP"

	outfit = /datum/outfit/job/robocop
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC
	departments_list = list(
		/datum/job_department/security,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)
	rpg_title = "Iron-Clad Arbiter"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN
	voice_of_god_power = 1.2 //RoboCop has some authority

/datum/outfit/job/robocop
	name = "RoboCop"
	jobtype = /datum/job/robocop

	id_trim = /datum/id_trim/job/robocop
	uniform = /obj/item/clothing/under/rank/security/officer
	head = /obj/item/clothing/head/helmet/hat/cowboy //monkestation edit: cowboy sec
	suit = /obj/item/clothing/suit/armor/secduster //monkestation edit: cowboy sec
	suit_store = /obj/item/gun/ballistic/automatic/pistol/paco/no_mag //monkestation edit: Paco sec
	backpack_contents = list(
		/obj/item/evidencebag = 1,
		/obj/item/ammo_box/magazine/m35/rubber = 2, //monkestation edit: Paco sec
		)
	belt = /obj/item/modular_computer/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/jackboots/sec
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld

	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	box = /obj/item/storage/box/survival/security
	chameleon_extras = list(
		/obj/item/clothing/glasses/hud/security/sunglasses,
		/obj/item/clothing/head/helmet,
		/obj/item/gun/energy/disabler,
		)
		//The helmet is necessary because /obj/item/clothing/head/helmet/sec is overwritten in the chameleon list by the standard helmet, which has the same name and icon state
	implants = list(/obj/item/implant/mindshield)
	skillchips = list(/obj/item/skillchip/job/robocop)

/datum/outfit/job/robocop/mod
	name = "RoboCop (MODsuit)"

	suit_store = /obj/item/tank/internals/oxygen
	back = /obj/item/mod/control/pre_equipped/security
	suit = null
	head = null
	mask = /obj/item/clothing/mask/gas/sechailer
	internals_slot = ITEM_SLOT_SUITSTORE
