local stringmanip = require("cc.strings")

-- Peripherals
nosound = false
speaker = peripheral.find("speaker")
if speaker == nil then
    nosound = true
end

-- Options
optionsopen = false

numberformat = 0
-- 0 = American
-- 1 = Scientific

timemeasurements = 1
-- 0 = $ per minute
-- 1 = $ per second

volume = 1

-- Basic set up of screen variables
width, height = term.getSize()
screenSizeMultiplier = width-9

-- Money
money = 0

-- Prestige
prestige = 0
prestigemultiplier = 1

-- Global UI offset for scrolling
offset = 0
maxscroll = 0

-- Levels of respective things
dirtlevel = 1
dirtprogress = 0
dirtpayout = 11
dirtunlocked = 2

sugarcanelevel = 1
sugarcaneprogress = 0
sugarcanepayout = 110
sugarcaneunlocked = 1

andesitelevel = 1
andesiteprogress = 0
andesitepayout = 1100
andesiteunlocked = 0

milklevel = 1
milkprogress = 0
milkpayout = 11000
milkunlocked = 0

zombielevel = 1
zombieprogress = 0
zombiepayout = 110000
zombieunlocked = 0

ironfarmlevel = 1
ironfarmprogress = 0
ironfarmpayout = 1100000
ironfarmunlocked = 0

lavafarmlevel = 1
lavafarmprogress = 0
lavafarmpayout = 11000000
lavafarmunlocked = 0

endfarmlevel = 1
endfarmprogress = 0
endfarmpayout = 110000000
endfarmunlocked = 0

withercheeselevel = 1
withercheeseprogress = 0
withercheesepayout = 1100000000
withercheeseunlocked = 0

sculklevel = 1
sculkprogress = 0
sculkpayout = 11000000000
sculkunlocked = 0

ancientdebrislevel = 1
ancientdebrisprogress = 0
ancientdebrispayout = 110000000000
ancientdebrisunlocked = 0

prestigeunlocked = 0

-- Load save data if present
file = io.open("mineclickersave.txt", "r+")
if file == nil then
    file = io.open("mineclickersave.txt", "w")
end
file:close()
file = io.open("mineclickersave.txt", "r")
io.input(file)
while true do
    data = io.read("l")
    if data == nil then
        break
    end
    split = stringmanip.split(data, "=")
    if split[1] == "numberformat" then
        numberformat = tonumber(split[2])
    end
    if split[1] == "timemeasurements" then
        timemeasurements = tonumber(split[2])
    end
    if split[1] == "volume" then
        volume = tonumber(split[2])
    end
    if split[1] == "money" then
        money = tonumber(split[2])
    end
    if split[1] == "dirtlevel" then
        dirtlevel = tonumber(split[2])
    end
    if split[1] == "sugarcanelevel" then
        sugarcanelevel = tonumber(split[2])
    end
    if split[1] == "andesitelevel" then
        andesitelevel = tonumber(split[2])
    end
    if split[1] == "milklevel" then
        milklevel = tonumber(split[2])
    end
    if split[1] == "zombielevel" then
        zombielevel = tonumber(split[2])
    end
    if split[1] == "ironfarmlevel" then
        ironfarmlevel = tonumber(split[2])
    end
    if split[1] == "lavafarmlevel" then
        lavafarmlevel = tonumber(split[2])
    end
    if split[1] == "endfarmlevel" then
        endfarmlevel = tonumber(split[2])
    end
    if split[1] == "withercheeselevel" then
        withercheeselevel = tonumber(split[2])
    end
    if split[1] == "sculklevel" then
        sculklevel = tonumber(split[2])
    end
    if split[1] == "ancientdebrislevel" then
        ancientdebrislevel = tonumber(split[2])
    end
    if split[1] == "prestige" then
        prestige = tonumber(split[2])
    end
    if split[1] == "prestigemultiplier" then
        prestigemultiplier = tonumber(split[2])
    end
end
file:close()

function updateSavefile ()
    file = io.open("mineclickersave.txt", "w")
    io.output(file)
    io.write(string.format("numberformat=%s\n", numberformat))
    io.write(string.format("timemeasurements=%s\n", timemeasurements))
    io.write(string.format("volume=%s\n", volume))
    io.write(string.format("money=%s\n", string.format("%.f", money)))
    io.write(string.format("dirtlevel=%s\n", dirtlevel))
    io.write(string.format("sugarcanelevel=%s\n", sugarcanelevel))
    io.write(string.format("andesitelevel=%s\n", andesitelevel))
    io.write(string.format("milklevel=%s\n", milklevel))
    io.write(string.format("zombielevel=%s\n", zombielevel))
    io.write(string.format("ironfarmlevel=%s\n", ironfarmlevel))
    io.write(string.format("lavafarmlevel=%s\n", lavafarmlevel))
    io.write(string.format("endfarmlevel=%s\n", endfarmlevel))
    io.write(string.format("withercheeselevel=%s\n", withercheeselevel))
    io.write(string.format("sculklevel=%s\n", sculklevel))
    io.write(string.format("ancientdebrislevel=%s\n", ancientdebrislevel))
    io.write(string.format("prestige=%s\n", prestige))
    io.write(string.format("prestigemultiplier=%s", prestigemultiplier))
    file:close()
end

function beautifyNumber (number)
    if numberformat == 0 then
        number = math.abs(number)
        if number < 10000 then
            return string.format("%s", number)
        elseif number >= 10000 and number < 999999 then
            return string.format("%sk", math.floor((number * 10) + 0.5) / 10 / 1000)
        elseif number >= 1000000 and number < 999999999 then
            return string.format("%sM", math.floor((number * 10) + 0.5) / 10 / 1000000)
        elseif number >= 1000000000 and number < 999999999999 then
            return string.format("%sB", math.floor((number * 10) + 0.5) / 10 / 1000000000)
        elseif number >= 1000000000000 and number < 999999999999999 then
            return string.format("%sT", math.floor((number * 10) + 0.5) / 10 / 1000000000000)
        elseif number >= 1000000000000000 and number < 999999999999999999 then
            return string.format("%sQui", math.floor((number * 10) + 0.5) / 10 / 1000000000000000)
        elseif number >= 1000000000000000000 and number < 999999999999999999999 then
            return string.format("%sQua", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000)
        elseif number >= 1000000000000000000000 and number < 999999999999999999999999 then
            return string.format("%sSex", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000)
        elseif number >= 1000000000000000000000000 and number < 999999999999999999999999999 then
            return string.format("%sSep", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000000)
        elseif number >= 1000000000000000000000000000 and number < 999999999999999999999999999999 then
            return string.format("%sOct", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000000000)
        elseif number >= 1000000000000000000000000000000 and number < 999999999999999999999999999999999 then
            return string.format("%sNon", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000000000000)
        elseif number >= 1000000000000000000000000000000000 and number < 999999999999999999999999999999999999 then
            return string.format("%sDec", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000000000000000)
        elseif number >= 1000000000000000000000000000000000000 and number < 999999999999999999999999999999999999999 then
            return string.format("%sUnd", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000000000000000000)
        elseif number >= 1000000000000000000000000000000000000000 and number < 999999999999999999999999999999999999999999 then
            return string.format("%sDuo", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000000000000000000000)
        elseif number >= 1000000000000000000000000000000000000000000 and number < 999999999999999999999999999999999999999999999 then
            return string.format("%sTre", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000000000000000000000000)
        elseif number >= 1000000000000000000000000000000000000000000000 and number < 999999999999999999999999999999999999999999999999 then
            return string.format("%sQuat", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000000000000000000000000000)
        elseif number >= 1000000000000000000000000000000000000000000000000 and number < 999999999999999999999999999999999999999999999999999 then
            return string.format("%sQuin", math.floor((number * 10) + 0.5) / 10 / 1000000000000000000000000000000000000000000000000)
        end
    elseif numberformat == 1 then
        number = math.abs(number)
        string = string.format("%s", number)
        length = string:len()
        if number > 10000 then
            enumber = 0
            finnumber = number
            while finnumber >= 10 do
                finnumber = finnumber / 10
                enumber = enumber + 1
            end
            return string.format("%se%s", math.floor((finnumber * 1000) + 0.5) / 1000, enumber)
        else
            return number
        end
    end
end

function drawGameBox (x, y, unlocked, name, level, color, progress, speed, payout, cost, toofast, textcolor, barbgcolor, lowertextcolor)
    if y > math.abs(offset) and y - height - 1 < math.abs(offset) then
        y = y + offset
        if unlocked == 2 then
            -- Draw background
            paintutils.drawFilledBox(x, y, width-1, y+2, color)
            -- Draw level text
            term.setTextColor(textcolor)
            term.setCursorPos(x+1, y)
            term.setBackgroundColor(color)
            term.write(string.format("%s - level %s", name, level))
            -- Draw bar bg
            paintutils.drawFilledBox(x+1, y+1, width-7, y+1, barbgcolor)
            -- Draw bar
            if toofast <= 0 then
                if progress ~= 0 then -- Make sure progress isn't 0, because then just don't draw
                    paintutils.drawFilledBox(x+1, y+1, (progress * screenSizeMultiplier) + x+1, y+1, colors.green)
                    -- Fuckery to make a smoother progress bar
                    lengthofbox = ((progress * screenSizeMultiplier) + x+1) - x+1
                    if lengthofbox - math.floor(lengthofbox + 0.5) > 0 then
                        term.setCursorPos((progress * screenSizeMultiplier) + x+1, y+1)
                        term.setTextColor(colors.green)
                        term.setBackgroundColor(barbgcolor)
                        write("\149")
                    end
                end
            else
                -- If in "too fast" mode then draw just an approximation instead
                paintutils.drawFilledBox(x+1, y+1, width-7, y+1, colors.green)
                for i=1+toofast%3,width-9,3 do
                    paintutils.drawPixel(x+i, y+1, colors.white)
                end
            end
            -- Draw buy button
            if money >= cost then
                paintutils.drawFilledBox(width-5, y, width-1, y+2, colors.green)
                term.setTextColor(colors.white)
                term.setBackgroundColor(colors.green)
            else
                -- Grey it out if it can't be bought yet
                paintutils.drawFilledBox(width-5, y, width-1, y+2, colors.lightGray)
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.lightGray)
            end
            term.setCursorPos(width-4, y+1)
            term.write("BUY")
            -- Draw bottom stat text
            term.setCursorPos(x+1, y+2)
            term.setBackgroundColor(color)
            term.setTextColor(lowertextcolor)
            -- Calculate and show money per second
            if timemeasurements == 0 then
                speedpretty = speed * 60 * 60 * payout
                term.write(string.format("%s $/m - %s$ to upgrade", beautifyNumber(math.floor(speedpretty + 0.5)), beautifyNumber(cost)))
            elseif timemeasurements == 1 then
                speedpretty = speed * 60 * payout
                term.write(string.format("%s $/s - %s$ to upgrade", beautifyNumber(math.floor(speedpretty + 0.5)), beautifyNumber(cost)))
            end
        elseif unlocked == 1 then
            -- If not unlocked but visible, display unlock prompt
            if money >= cost then
                paintutils.drawFilledBox(x, y, width-1, y+2, colors.green)
                term.setTextColor(colors.white)
                term.setBackgroundColor(colors.green)
            else
                -- Grey it out if it can't be bought yet
                paintutils.drawFilledBox(x, y, width-1, y+2, colors.lightGray)
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.lightGray)
            end
            term.setCursorPos(x+1, y+1)
            write(string.format("Buy %s for %s$", name, cost))
        end
    end
end

function drawPrestigeBox (x, y, unlocked)
    y = y + offset
    if unlocked == 2 then
        paintutils.drawFilledBox(x, y, width-1, y+2, colors.pink)
        term.setTextColor(colors.black)
        term.setBackgroundColor(colors.pink)
        term.setCursorPos(x+1, y+1)
        write("PRESTIGE!")
    elseif unlocked == 1 then
        paintutils.drawFilledBox(x, y, width-1, y+3, colors.lightGray)
        term.setTextColor(colors.black)
        term.setBackgroundColor(colors.lightGray)
        term.setCursorPos(x+1, y+1)
        write("Reach ancient debris")
        term.setCursorPos(x+1, y+2)
        write("level 50 for prestige")
    end
end

function touchThread ()
    while true do
        -- Touch handling
        local event, button, x, y = os.pullEvent("mouse_click")
        if button == 1 or button == 2 then
            if y == 3 and x == width then
                offset = offset + 1
                if nosound == false then
                    speaker.playSound("ui.button.click", volume)
                end
            elseif y == height and x == width then
                offset = offset - 1
                if nosound == false then
                    speaker.playSound("ui.button.click", volume)
                end
            elseif y == 1 and x >= 16 and x <= 23 then
                if optionsopen == false then
                    optionsopen = true
                elseif optionsopen == true then
                    optionsopen = false
                end
                if nosound == false then
                    speaker.playSound("ui.button.click", volume)
                end
            end
            if offset > 0 then offset = 0 end
            if offset < -maxscroll then offset = -maxscroll end
            y = y - offset
            if optionsopen == false then
                if y >= 4 and y <= 6 and money >= dirtcost then
                    if x >= width-5 and x <= width-1 and dirtunlocked == 2 then
                        dirtlevel = dirtlevel + 1
                        money = money - dirtcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and dirtunlocked == 1 then
                        dirtunlocked = 2
                        money = money - dirtcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 8 and y <= 10 and money >= sugarcanecost then
                    if x >= width-5 and x <= width-1 and sugarcaneunlocked == 2 then
                        sugarcanelevel = sugarcanelevel + 1
                        money = money - sugarcanecost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and sugarcaneunlocked == 1 then
                        sugarcaneunlocked = 2
                        andesiteunlocked = 1
                        money = money - sugarcanecost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 12 and y <= 14 and money >= andesitecost then
                    if x >= width-5 and x <= width-1 and andesiteunlocked == 2 then
                        andesitelevel = andesitelevel + 1
                        money = money - andesitecost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and andesiteunlocked == 1 then
                        andesiteunlocked = 2
                        milkunlocked = 1
                        money = money - andesitecost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 16 and y <= 18 and money >= milkcost then
                    if x >= width-5 and x <= width-1 and milkunlocked == 2 then
                        milklevel = milklevel + 1
                        money = money - milkcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and milkunlocked == 1 then
                        milkunlocked = 2
                        zombieunlocked = 1
                        maxscroll = 4
                        money = money - milkcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 20 and y <= 22 and money >= zombiecost then
                    if x >= width-5 and x <= width-1 and zombieunlocked == 2 then
                        zombielevel = zombielevel + 1
                        money = money - zombiecost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and zombieunlocked == 1 then
                        zombieunlocked = 2
                        ironfarmunlocked = 1
                        maxscroll = 8
                        money = money - zombiecost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 24 and y <= 26 and money >= ironfarmcost then
                    if x >= width-5 and x <= width-1 and ironfarmunlocked == 2 then
                        ironfarmlevel = ironfarmlevel + 1
                        money = money - ironfarmcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and ironfarmunlocked == 1 then
                        ironfarmunlocked = 2
                        lavafarmunlocked = 1
                        maxscroll = 12
                        money = money - ironfarmcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 28 and y <= 30 and money >= lavafarmcost then
                    if x >= width-5 and x <= width-1 and lavafarmunlocked == 2 then
                        lavafarmlevel = lavafarmlevel + 1
                        money = money - lavafarmcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and lavafarmunlocked == 1 then
                        lavafarmunlocked = 2
                        endfarmunlocked = 1
                        maxscroll = 16
                        money = money - lavafarmcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 32 and y <= 34 and money >= endfarmcost then
                    if x >= width-5 and x <= width-1 and endfarmunlocked == 2 then
                        endfarmlevel = endfarmlevel + 1
                        money = money - endfarmcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and endfarmunlocked == 1 then
                        endfarmunlocked = 2
                        withercheeseunlocked = 1
                        maxscroll = 20
                        money = money - endfarmcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 36 and y <= 38 and money >= withercheesecost then
                    if x >= width-5 and x <= width-1 and withercheeseunlocked == 2 then
                        withercheeselevel = withercheeselevel + 1
                        money = money - withercheesecost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and withercheeseunlocked == 1 then
                        withercheeseunlocked = 2
                        sculkunlocked = 1
                        maxscroll = 24
                        money = money - withercheesecost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 40 and y <= 42 and money >= sculkcost then
                    if x >= width-5 and x <= width-1 and sculkunlocked == 2 then
                        sculklevel = sculklevel + 1
                        money = money - sculkcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and sculkunlocked == 1 then
                        sculkunlocked = 2
                        ancientdebrisunlocked = 1
                        maxscroll = 28
                        money = money - sculkcost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 44 and y <= 46 and money >= ancientdebriscost then
                    if x >= width-5 and x <= width-1 and ancientdebrisunlocked == 2 then
                        ancientdebrislevel = ancientdebrislevel + 1
                        money = money - ancientdebriscost
                        if ancientdebrislevel >= 50 then
                            prestigeunlocked = 2
                        end
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    elseif x >= 2 and x <= width-1 and ancientdebrisunlocked == 1 then
                        ancientdebrisunlocked = 2
                        prestigeunlocked = 1
                        maxscroll = 33
                        money = money - ancientdebriscost
                        if nosound == false then
                            speaker.playSound("entity.experience_orb.pickup", volume)
                        end
                    end
                end
                if y >= 48 and y <= 51 and ancientdebrislevel >= 50 then
                    if x >= 2 and x <= width-1 and prestigeunlocked == 2 then
                        prestige = prestige + 1
                        prestigemultiplier = 1 + (prestige * 0.5)
                        offset = 0
                        maxscroll = 0
                        money = 0
                        -- Reset all the levels
                        dirtlevel = 1
                        sugarcanelevel = 1
                        andesitelevel = 1
                        milklevel = 1
                        zombielevel = 1
                        ironfarmlevel = 1
                        lavafarmlevel = 1
                        endfarmlevel = 1
                        withercheeselevel = 1
                        sculklevel = 1
                        ancientdebrislevel = 1
                        -- Reset unlocks
                        sugarcaneunlocked = 1
                        andesiteunlocked = 0
                        milkunlocked = 0
                        zombieunlocked = 0
                        ironfarmunlocked = 0
                        lavafarmunlocked = 0
                        endfarmunlocked = 0
                        withercheeseunlocked = 0
                        sculkunlocked = 0
                        ancientdebrisunlocked = 0
                        if nosound == false then
                            speaker.playSound("entity.ender_dragon.death", volume)
                        end
                    end
                end
            else
                if y == 5 then
                    if x >= 2 and x <= 9 then
                        numberformat = 0
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                    if x >= 12 and x <= 21 then
                        numberformat = 1
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                end
                if y == 8 then
                    if x >= 2 and x <= 11 then
                        timemeasurements = 0
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                    if x >= 14 and x <= 23 then
                        timemeasurements = 1
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                end
                if y == 11 then
                    if x == 2 then
                        volume = 0
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                    if x >= 4 and x <= 7 then
                        volume = 0.25
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                    if x >= 9 and x <= 11 then
                        volume = 0.5
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                    if x >= 13 and x <= 16 then
                        volume = 0.75
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                    if x == 18 then
                        volume = 1
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                    if x == 20 then
                        volume = 2
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                    if x == 22 then
                        volume = 3
                        if nosound == false then
                            speaker.playSound("ui.button.click", volume)
                        end
                    end
                end
            end
        end
    end
end

function mainThread ()
    frame = 0
    while true do
        frame = frame + 1

        -- Dirt Shoveling
        if dirtunlocked == 2 then
            dirtspeed = (dirtlevel * 0.006)
        else
            dirtspeed = 0
        end
        dirtcost = dirtlevel * 15
        dirtprogress = dirtprogress + dirtspeed
        if dirtprogress > 1 then
            dirtprogress = 0
            money = money + dirtpayout * prestigemultiplier
            if nosound == false and dirtfast == 0 then
                speaker.playSound("block.gravel.break", volume)
            end
        end
        if dirtspeed > 0.15 then
            dirtfast = frame
        else
            dirtfast = 0
        end

        -- Sugar Cane Plantation
        if sugarcaneunlocked == 2 then
            sugarcanespeed = (sugarcanelevel * 0.0055)
        else
            sugarcanespeed = 0
        end
        sugarcanecost = sugarcanelevel * 103
        sugarcaneprogress = sugarcaneprogress + sugarcanespeed
        if sugarcaneprogress > 1 then
            sugarcaneprogress = 0
            if nosound == false and sugarcanefast == 0 then
                speaker.playSound("block.grass.break", volume)
            end
            money = money + sugarcanepayout * prestigemultiplier
        end
        if sugarcanespeed > 0.15 then
            sugarcanefast = frame
        else
            sugarcanefast = 0
        end

        -- Andesite Quarry
        if andesiteunlocked == 2 then
            andesitespeed = (andesitelevel * 0.005)
        else
            andesitespeed = 0
        end
        andesitecost = andesitelevel * 1069
        andesiteprogress = andesiteprogress + andesitespeed
        if andesiteprogress > 1 then
            andesiteprogress = 0
            if nosound == false and andesitefast == 0 then
                speaker.playSound("block.stone.break", volume)
            end
            money = money + andesitepayout * prestigemultiplier
        end
        if andesitespeed > 0.15 then
            andesitefast = frame
        else
            andesitefast = 0
        end

        -- Milk Farm
        if milkunlocked == 2 then
            milkspeed = (milklevel * 0.0045)
        else
            milkspeed = 0
        end
        milkcost = milklevel * 10033
        milkprogress = milkprogress + milkspeed
        if milkprogress > 1 then
            milkprogress = 0
            if nosound == false and milkfast == 0 then
                speaker.playSound("entity.cow.milk", volume)
            end
            money = money + milkpayout * prestigemultiplier
        end
        if milkspeed > 0.15 then
            milkfast = frame
        else
            milkfast = 0
        end

        -- Zombie Spawner
        if zombieunlocked == 2 then
            zombiespeed = (zombielevel * 0.004)
        else
            zombiespeed = 0
        end
        zombiecost = zombielevel * 100420
        zombieprogress = zombieprogress + zombiespeed
        if zombieprogress > 1 then
            zombieprogress = 0
            if nosound == false and zombiefast == 0 then
                speaker.playSound("entity.zombie.hurt", volume)
            end
            money = money + zombiepayout * prestigemultiplier
        end
        if zombiespeed > 0.15 then
            zombiefast = frame
        else
            zombiefast = 0
        end

        -- Iron Golem Farm
        if ironfarmunlocked == 2 then
            ironfarmspeed = (ironfarmlevel * 0.0035)
        else
            ironfarmspeed = 0
        end
        ironfarmcost = ironfarmlevel * 1001337
        ironfarmprogress = ironfarmprogress + ironfarmspeed
        if ironfarmprogress > 1 then
            ironfarmprogress = 0
            if nosound == false and ironfarmfast == 0 then
                speaker.playSound("entity.iron_golem.hurt", volume)
            end
            money = money + ironfarmpayout * prestigemultiplier
        end
        if ironfarmspeed > 0.15 then
            ironfarmfast = frame
        else
            ironfarmfast = 0
        end

        -- Lava Farm
        if lavafarmunlocked == 2 then
            lavafarmspeed = (lavafarmlevel * 0.003)
        else
            lavafarmspeed = 0
        end
        lavafarmcost = lavafarmlevel * 10012345
        lavafarmprogress = lavafarmprogress + lavafarmspeed
        if lavafarmprogress > 1 then
            lavafarmprogress = 0
            if nosound == false and lavafarmfast == 0 then
                speaker.playSound("item.bucket.fill_lava", volume)
            end
            money = money + lavafarmpayout * prestigemultiplier
        end
        if lavafarmspeed > 0.15 then
            lavafarmfast = frame
        else
            lavafarmfast = 0
        end

        -- End Farm
        if endfarmunlocked == 2 then
            endfarmspeed = (endfarmlevel * 0.0025)
        else
            endfarmspeed = 0
        end
        endfarmcost = endfarmlevel * 100846759
        endfarmprogress = endfarmprogress + endfarmspeed
        if endfarmprogress > 1 then
            endfarmprogress = 0
            if nosound == false and endfarmfast == 0 then
                speaker.playSound("entity.enderman.hurt", volume)
            end
            money = money + endfarmpayout * prestigemultiplier
        end
        if endfarmspeed > 0.15 then
            endfarmfast = frame
        else
            endfarmfast = 0
        end

        -- Wither Slaughterhouse
        if withercheeseunlocked == 2 then
            withercheesespeed = (withercheeselevel * 0.002)
        else
            withercheesespeed = 0
        end
        withercheesecost = withercheeselevel * 1004756948
        withercheeseprogress = withercheeseprogress + withercheesespeed
        if withercheeseprogress > 1 then
            withercheeseprogress = 0
            if nosound == false and withercheesefast == 0 then
                speaker.playSound("entity.wither.hurt", volume)
            end
            money = money + withercheesepayout * prestigemultiplier
        end
        if withercheesespeed > 0.15 then
            withercheesefast = frame
        else
            withercheesefast = 0
        end

        -- Sculk Farm
        if sculkunlocked == 2 then
            sculkspeed = (sculklevel * 0.0015)
        else
            sculkspeed = 0
        end
        sculkcost = sculklevel * 10084769483
        sculkprogress = sculkprogress + sculkspeed
        if sculkprogress > 1 then
            sculkprogress = 0
            if nosound == false and sculkfast == 0 then
                speaker.playSound("entity.warden.hurt", volume)
            end
            money = money + sculkpayout * prestigemultiplier
        end
        if sculkspeed > 0.15 then
            sculkfast = frame
        else
            sculkfast = 0
        end

        -- Ancient Debris Mine
        if ancientdebrisunlocked == 2 then
            ancientdebrisspeed = (ancientdebrislevel * 0.001)
        else
            ancientdebrisspeed = 0
        end
        ancientdebriscost = ancientdebrislevel * 100938475621
        ancientdebrisprogress = ancientdebrisprogress + ancientdebrisspeed
        if ancientdebrisprogress > 1 then
            ancientdebrisprogress = 0
            if nosound == false and ancientdebrisfast == 0 then
                speaker.playSound("blocks.ancient_debris.break", volume)
            end
            money = money + ancientdebrispayout * prestigemultiplier
        end
        if ancientdebrisspeed > 0.15 then
            ancientdebrisfast = frame
        else
            ancientdebrisfast = 0
        end

        -- Draw all the stuff

        if optionsopen == false then
            -- Clear screen
            paintutils.drawFilledBox(1, 1, width, height, colors.black)

            drawGameBox(2, 4, dirtunlocked, "Dirt Shoveling", dirtlevel, colors.brown, dirtprogress, dirtspeed, dirtpayout, dirtcost, dirtfast, colors.white, colors.gray, colors.lightGray)

            drawGameBox(2, 8, sugarcaneunlocked, "Sugar Cane Plantation", sugarcanelevel, colors.lime, sugarcaneprogress, sugarcanespeed, sugarcanepayout, sugarcanecost, sugarcanefast, colors.black, colors.gray, colors.gray)

            drawGameBox(2, 12, andesiteunlocked, "Andesite Quarry", andesitelevel, colors.gray, andesiteprogress, andesitespeed, andesitepayout, andesitecost, andesitefast, colors.white, colors.black, colors.lightGray)

            drawGameBox(2, 16, milkunlocked, "Milk Farm", milklevel, colors.white, milkprogress, milkspeed, milkpayout, milkcost, milkfast, colors.black, colors.gray, colors.gray)

            drawGameBox(2, 20, zombieunlocked, "Zombie Spawner", zombielevel, colors.gray, zombieprogress, zombiespeed, zombiepayout, zombiecost, zombiefast, colors.white, colors.black, colors.lightGray)

            drawGameBox(2, 24, ironfarmunlocked, "Iron Golem Farm", ironfarmlevel, colors.white, ironfarmprogress, ironfarmspeed, ironfarmpayout, ironfarmcost, ironfarmfast, colors.black, colors.gray, colors.gray)

            drawGameBox(2, 28, lavafarmunlocked, "Lava Dripstone Farm", lavafarmlevel, colors.orange, lavafarmprogress, lavafarmspeed, lavafarmpayout, lavafarmcost, lavafarmfast, colors.black, colors.black, colors.lightGray)

            drawGameBox(2, 32, endfarmunlocked, "Enderman XP Farm", endfarmlevel, colors.purple, endfarmprogress, endfarmspeed, endfarmpayout, endfarmcost, endfarmfast, colors.white, colors.gray, colors.white)

            drawGameBox(2, 36, withercheeseunlocked, "Wither Slaughterhouse", withercheeselevel, colors.black, withercheeseprogress, withercheesespeed, withercheesepayout, withercheesecost, withercheesefast, colors.white, colors.gray, colors.lightGray)

            drawGameBox(2, 40, sculkunlocked, "Sculk Farm", sculklevel, colors.blue, sculkprogress, sculkspeed, sculkpayout, sculkcost, sculkfast, colors.white, colors.gray, colors.lightGray)

            drawGameBox(2, 44, ancientdebrisunlocked, "Ancient Debris Mine", ancientdebrislevel, colors.brown, ancientdebrisprogress, ancientdebrisspeed, ancientdebrispayout, ancientdebriscost, ancientdebrisfast, colors.white, colors.gray, colors.lightGray)

            drawPrestigeBox(2, 48, prestigeunlocked)

            -- Draw scroll buttons
            term.setTextColor(colors.lightGray)
            term.setBackgroundColor(colors.black)
            term.setCursorPos(width, 3)
            term.write("\24")
            term.setCursorPos(width, height)
            term.write("\25")
        else
            -- Options background
            paintutils.drawFilledBox(1, 1, width, height, colors.gray)

            -- Draw format selection
            term.setCursorPos(2, 4)
            term.setTextColor(colors.white)
            term.write("Big number notation")
            paintutils.drawFilledBox(1, 5, width, 5, colors.black)
            term.setCursorPos(2, 5)
            if numberformat == 0 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("American")
            term.setCursorPos(12, 5)
            if numberformat == 1 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("Scientific")

            -- Speed unit selection
            term.setCursorPos(2, 7)
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.gray)
            term.write("Speed unit")
            paintutils.drawFilledBox(1, 8, width, 8, colors.black)
            term.setCursorPos(2, 8)
            if timemeasurements == 0 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("per minute")
            term.setCursorPos(14, 8)
            if timemeasurements == 1 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("per second")

            -- Volume
            term.setCursorPos(2, 10)
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.gray)
            term.write("Volume")
            paintutils.drawFilledBox(1, 11, width, 11, colors.black)
            term.setCursorPos(2, 11)
            if volume == 0 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("0")
            term.setCursorPos(4, 11)
            if volume == 0.25 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("0.25")
            term.setCursorPos(9, 11)
            if volume == 0.5 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("0.5")
            term.setCursorPos(13, 11)
            if volume == 0.75 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("0.75")
            term.setCursorPos(18, 11)
            if volume == 1 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("1")
            term.setCursorPos(20, 11)
            if volume == 2 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("2")
            term.setCursorPos(22, 11)
            if volume == 3 then
                term.setTextColor(colors.white)
            else
                term.setTextColor(colors.blue)
            end
            term.write("3")

            -- Credit
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.gray)
            term.setCursorPos(2, 13)
            term.write("Mineclicker 1.0.0.")
            term.setCursorPos(2, 14)
            term.write("Game made by Sparkwave in 2025.")
            term.setCursorPos(2, 15)
            term.write("This game autosaves every 10 seconds.")
            term.setCursorPos(2, 16)
            term.write("To delete your savefile,")
            term.setCursorPos(2, 17)
            term.write("simply delete mineclickersave.txt.")
        end

        -- Draw top bar last so that it's over everything else
        paintutils.drawFilledBox(1, 1, width, 1, colors.red)
        term.setCursorPos(1, 1)
        term.setTextColor(colors.white)
        term.setCursorPos(2, 1)
        term.write("Mine Clicker")
        moneytext = string.format("%s$", beautifyNumber(money))
        term.setCursorPos(width-0-string.len(moneytext), 1)
        term.write(moneytext)
        -- Draw settings button
        term.setCursorPos(16, 1)
        term.setBackgroundColor(colors.gray)
        term.write("Settings")
        -- Draw prestige bar
        paintutils.drawFilledBox(1, 2, width, 2, colors.pink)
        term.setTextColor(colors.black)
        term.setCursorPos(2, 2)
        term.write(string.format("Prestige - level %s - x%s", prestige, math.floor((prestigemultiplier * 10) + 0.5) / 10))
        --term.setCursorPos(width-6, 2)
        --term.setTextColor(colors.white)
        --term.setBackgroundColor(colors.green)
        --term.write("ASCEND")

        -- Save data every 10 seconds
        if frame % 600 == 0 then
            updateSavefile()
        end
        
        -- 60 fps
        os.sleep(0.016666666666666666)
    end
end

parallel.waitForAll(mainThread, touchThread)

term.setCursorPos(0, height)