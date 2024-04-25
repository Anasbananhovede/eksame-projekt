extends Control



func heart_display(amount : int):
	$Heart1.visible = false
	$Heart2.visible = false
	$Heart3.visible = false
	if amount>=1:
		$Heart1.visible = true
	if amount>=2:
		$Heart2.visible = true
	
	if amount>=3:
		$Heart3.visible = true
