extends Panel


func loadLists():
	var active = get_node("ActiveParty")
	var inactive = get_node("InactiveParty")
	var resources = get_node("ResourcesList")
	
	active.clear()
	inactive.clear()
	resources.clear()
	
	# Loads active party
	for member in MainData.party.active:
		var listStr = member.name + " - " + "Bond: " + str(member.bondLevel()) + " - "
		var skillStr = ""
		var index = 0
		for skill in member.skills:
			skillStr += skill.name + ": " + str(skill.level())
			index += 1
			if index < member.skills.size():
				skillStr += ", "
		listStr += skillStr
		active.add_item(listStr)
		
	# Loads inactive party
	for member in MainData.party.inactive:
		var listStr = member.name + " - " + "Bond: " + str(member.bondLevel()) + " - "
		var skillStr = ""
		var index = 0
		for skill in member.skills:
			skillStr += skill.name + ": " + str(skill.level())
			index += 1
			if index < member.skills.size():
				skillStr += ", "
		listStr += skillStr
		inactive.add_item(listStr)
		
	for resource in MainData.party.resources:
		var resourceStr = resource + ": " + str(MainData.party.resources[resource])
		resources.add_item(resourceStr)
		
func setInactive():
	var active = get_node("ActiveParty")
	var selectedMember = active.get_selected_items()
	if selectedMember.size() == 1:
		var character = MainData.party.active[selectedMember[0]]
		MainData.party.setInactive(character)
		loadLists()

func setActive():
	var inactive = get_node("InactiveParty")
	var selectedMember = inactive.get_selected_items()
	if selectedMember.size() == 1:
		var character = MainData.party.inactive[selectedMember[0]]
		if (character.isAvailable()):
			MainData.party.setActive(character)
			loadLists()