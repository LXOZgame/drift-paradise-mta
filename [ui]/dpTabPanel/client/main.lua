local isActive = false

function setVisible(visible)
	visible = not not visible
	if localPlayer:getData("dpCore.state") or exports.dpMainPanel:isVisible() then
		visible = false
	end
	if isActive == visible then
		return
	end	
	exports.dpUI:fadeScreen(visible)
	isActive = visible
	showCursor(visible)
	exports.dpHUD:setVisible(not visible)
	if visible then
		Panel.start()
	else
		Panel.stop()
	end
end

local function show()
	setVisible(true)
end

local function hide()
	setVisible(false)
end

bindKey("tab", "down", show)
bindKey("tab", "up", hide)

--show()

function isVisible()
	return isActive
end