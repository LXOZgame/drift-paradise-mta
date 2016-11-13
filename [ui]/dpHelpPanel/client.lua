local UI = exports.dpUI

local isVisible = false
local screenWidth, screenHeight = UI:getScreenSize()
local width = 640
local height = 480
local tabWidth
local tabHeight = 50
local ui = {}
local tabs = {
    {
        name = "Основное",
        text = "Добро пожаловать на Drift Paradise! Сервер збс всё збс сосите писос.\n\nЗдесь надо играть короч збс ваще"
    },
    {
        name = "Гараж",
        text = "Тест"
    },    
    {
        name = "Гонки",
        text = "Тест"
    },
    {
        name = "Разработчики",
        text = "Никита Бредихин всё сделал а остальные - пидоры"
    }    
}

local function showTab(index)
    if not tabs[index] then
        return false
    end

    for i, tab in ipairs(tabs) do
        if tab.button then
            UI:setType(tab.button, "default_dark")
        end
    end
    local tab = tabs[index]
    UI:setType(tab.button, "primary")
    UI:setText(ui.textLabel, tab.text)
end

function show()
    if localPlayer:getData("activeUI") then
        return false
    end
    if isVisible then
        return false
    end
    isVisible = true
    localPlayer:setData("activeUI", "helpPanel")
    showCursor(true)
    exports.dpUI:fadeScreen(true)
    UI:setVisible(ui.panel, true)
end

function hide()
    if not isVisible then
        return false
    end
    isVisible = false
    localPlayer:setData("activeUI", false)
    showCursor(false)
    exports.dpUI:fadeScreen(false)
    UI:setVisible(ui.panel, false)
end

addEventHandler("onClientResourceStart", resourceRoot, function ()
    if localPlayer:getData("activeUI") == "helpPanel" then
        localPlayer:setData("activeUI", false)
    end

    ui.panel = UI:createDpPanel {
        x = (screenWidth - width) / 2,
        y = (screenHeight - height) / 1.7,
        width = width,
        height = height,
        type = "light"
    }
    UI:addChild(ui.panel)

    tabWidth = width / #tabs
    for i, tab in ipairs(tabs) do
        tab.button = UI:createDpButton {
            x = (i - 1) * tabWidth,
            y = 0,
            width = tabWidth,
            height = tabHeight,
            type = "default_dark",
            fontType = "defaultSmall",
            locale = tab.name
        }
        UI:addChild(ui.panel, tab.button)
    end

    ui.textLabel = UI:createDpLabel({
        x = 20 , y = tabHeight + 20,
        width = width - 40, height = height,
        type = "dark",
        fontType = "default",
        text = "...",
        alignX = "left",
        alignY = "top",
        wordBreak = true
    })
    UI:addChild(ui.panel, ui.textLabel)     

    UI:setVisible(ui.panel, false)

    showTab(1)
end)

bindKey("f9", "down", function ()
    if not isVisible then
        show()
    else
        hide()
    end
end)

addEvent("dpUI.click", false)
addEventHandler("dpUI.click", resourceRoot, function (widget)
    for i, tab in ipairs(tabs) do
        if tab.button == widget then
            showTab(i)
            exports.dpSounds:playSound("ui_select.wav")
            return
        end
    end 
end)