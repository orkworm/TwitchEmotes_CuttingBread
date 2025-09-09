local path = "Interface\\AddOns\\TwitchEmotes_CuttingBread\\Emotes\\"

-- === Animated emotes support (vertical spritesheets), thanks gpt ===
-- 1) Register animation metadata in TwitchEmotes_animation_metadata
-- 2) Shim TwitchEmotesAnimator_UpdateEmoteInFontString so our addon path is animated

-- Helper to register animation metadata for spritesheets
-- path: full texture path (Interface\\AddOns\\TwitchEmotes_CuttingBread\\Emotes\\NAME.tga)
-- nFrames: total number of frames in the spritesheet (stacked vertically)
-- frameWidth/frameHeight: single frame dimensions in pixels
-- imageWidth/imageHeight: full image dimensions in pixels
-- framerate: frames per second
-- pingpong: optional boolean to play forward then backward
function TwitchEmotesCuttingBread_AddAnimation(texPath, nFrames, frameWidth, frameHeight, imageWidth, imageHeight, framerate, pingpong)
    TwitchEmotes_animation_metadata = TwitchEmotes_animation_metadata or {}
    TwitchEmotes_animation_metadata[texPath] = {
        nFrames = nFrames,
        frameWidth = frameWidth,
        frameHeight = frameHeight,
        imageWidth = imageWidth,
        imageHeight = imageHeight,
        framerate = framerate or 15,
        pingpong = pingpong or false,
        -- Vertical strip
        layout = "vertical"
    }
end

-- Shim the animator to also handle our addon texture path
do
    local function isCuttingBreadPath(p)
        return p and (p:find("Interface\\AddOns\\TwitchEmotes_CuttingBread\\Emotes") ~= nil)
    end

    local _orig_UpdateEmoteInFontString = _G.TwitchEmotesAnimator_UpdateEmoteInFontString
    if _orig_UpdateEmoteInFontString then
        TwitchEmotesAnimator_UpdateEmoteInFontString = function(fontstring, widthOverride, heightOverride)
            -- First, let the original updater do its work (handles base TwitchEmotes paths)
            _orig_UpdateEmoteInFontString(fontstring, widthOverride, heightOverride)

            -- Now, update any CuttingBread emotes that are animated
            local txt = fontstring:GetText()
            if not txt then return end

            for emoteTextureString in txt:gmatch("(|TInterface\\AddOns\\TwitchEmotes_CuttingBread\\Emotes.-|t)") do
                local imagepath = emoteTextureString:match("|T(Interface\\AddOns\\TwitchEmotes_CuttingBread\\Emotes.-%.tga)")
                if imagepath and isCuttingBreadPath(imagepath) then
                    local animdata = TwitchEmotes_animation_metadata and TwitchEmotes_animation_metadata[imagepath]
                    if animdata then
                        -- Current frame number from TwitchEmotes helpers
                        local framenum = _G.TwitchEmotes_GetCurrentFrameNum and _G.TwitchEmotes_GetCurrentFrameNum(animdata) or 1

                        -- Use overrides if provided, else read from the texture tag, else default to frame size
                        local w, h
                        if widthOverride and heightOverride then
                            w, h = widthOverride, heightOverride
                        else
                            local tagW, tagH = emoteTextureString:match("%.tga:(%d+):(%d+)")
                            w = tonumber(tagW) or animdata.frameWidth
                            h = tonumber(tagH) or animdata.frameHeight
                        end

                        -- Compute pixel crop for vertical frame
                        local left, right = 0, animdata.frameWidth
                        local top = (math.max(framenum, 1) - 1) * animdata.frameHeight
                        local bottom = top + animdata.frameHeight

                        -- Rebuild the texture tag with pixel cropping:
                        -- |Tpath:W:H:offX:offY:imgW:imgH:cropL:cropR:cropT:cropB|t
                        local replacement = string.format("|T%s:%d:%d:0:0:%d:%d:%d:%d:%d:%d|t",
                            imagepath, w, h,
                            animdata.imageWidth, animdata.imageHeight,
                            left, right, top, bottom
                        )

                        -- Replace only this occurrence
                        local safePattern = emoteTextureString:gsub("([%^%$%(%)%%%._%[%]%*%+%-%?])", "%%%1")
                        txt = txt:gsub(safePattern, replacement, 1)
                    end
                end
            end

            -- Apply updated text if any changes were made
            fontstring:SetText(txt)
        end
    end
end

local cuttingbread_emotes = {
    -- IMPORTANT: For animated, keep only display width:height here.
    -- The frame count is handled by the animation metadata registration below.
    ["polish"] = path .. "polish.tga:32:32",
	["awkwardMonke"] = path .. "awkwardMonke.tga:32:32",
	["amuletofretard"] = path .. "amuletofretard.tga:32:32",
	["eating"] = path .. "eating.tga:32:32",
    ["yuh2"] = path .. "yuh2.tga:56:56",
	["nuke"] = path .. "nuke.tga:32:32",
    ["ooh"] = path .. "ooh.tga:32:32",
	["AUUGH"] = path .. "AUUGH.tga:32:32",
	["vegan"] = path .. "vegan.tga:32:32",
	["wooow"] = path .. "wooow.tga:32:32",
	["disappear"] = path .. "disappear.tga:32:32",
	["smash"] = path .. "smash.tga:32:32",
	["spit"] = path .. "spit.tga:32:32",
	["classic"] = path .. "classic.tga:32:32",
	["comrade"] = path .. "ComradePepe.tga:32:32",
	["dealwithit"] = path .. "dealwithit.tga:32:32",
	["elclassico"] = path .. "elclassico.tga:32:32",
	["greenclassic"] = path .. "greenclassic.tga:32:32",
	["yap"] = path .. "yap.tga:32:32",
	["docyap"] = path .. "docyap.tga:32:32",
	["1984"] = path .. "1984.tga:32:32",
	["ret"] = path .. "ret.tga:32:32",
	["BANGER"] = path .. "BANGER.tga:32:32",
	["wifecheck"] = path .. "wifecheck.tga:32:32",
	["iq"] = path .. "iq.tga:32:32",
	["9parse"] = path .. "9parse.tga:32:32",	
	["assault"] = path .. "assault.tga:32:32",	
		
	
	-- static, HxW
    ["1090sir"] = path .. "1090sir.tga:28:28",
    ["1960bread"] = path .. "1960bread.tga:28:28",
    ["3_"] = path .. "3_.tga:28:20",
    ["5head"] = path .. "5head.tga:28:28",
    ["8748_gigachad"] = path .. "8748_gigachad.tga:28:28",
    ["aa3Imgur"] = path .. "aa3Imgur.tga:28:28",
    ["aa5Imgur"] = path .. "aa5Imgur.tga:28:28",
    ["actualgoodjoblads"] = path .. "actualgoodjoblads.tga:56:28",
    ["affli"] = path .. "affli.tga:28:28",
    ["andrewohmy"] = path .. "andrewohmy.tga:28:28",
    ["andrew"] = path .. "andrew.tga:28:28",
    ["anxietyhut"] = path .. "anxietyhut.tga:28:28",
    ["baldworm"] = path .. "baldworm.tga:28:28",
    ["benched"] = path .. "benched.tga:28:28",
    ["catpoint"] = path .. "catpoint.tga:28:28",
    ["caught"] = path .. "caught.tga:28:56",
    ["charlie"] = path .. "charlie.tga:28:28",
    ["cinema"] = path .. "cinema.tga:30:84",
    ["cockge"] = path .. "cockge.tga:28:28",
    ["cringe"] = path .. "cringe.tga:28:23",
    ["cupcake"] = path .. "cupcake.tga:28:28",
    ["demo"] = path .. "demo.tga:28:28",
    ["destro"] = path .. "destro.tga:28:28",
    ["diessunday"] = path .. "diessunday.tga:28:28",
    ["drability"] = path .. "drability.tga:28:28",
    ["dumbass"] = path .. "dumbass.tga:28:28",
    ["fatgenius"] = path .. "fatgenius.tga:28:28",
    ["frost"] = path .. "frost.tga:29:61",
    ["genius"] = path .. "genius.tga:28:28",
    ["gigachad"] = path .. "gigachad.tga:28:28",
    ["goodjoblads1"] = path .. "goodjoblads~1.tga:28:28",
    ["goodjoblads2"] = path .. "goodjoblads~2.tga:28:18",
    ["goodjoblads3"] = path .. "goodjoblads~3.tga:64:41",
    ["goodjoblads4"] = path .. "goodjoblads~4.tga:28:28",
    ["goodjoblads"] = path .. "goodjoblads.tga:28:28",
    ["hard"] = path .. "hard.tga:28:28",
    ["hitler"] = path .. "hitler.tga:28:28",
    ["huh"] = path .. "huh.tga:28:28",
    ["icant"] = path .. "icant.tga:28:28",
    ["ItsCritical"] = path .. "ItsCritical.tga:34:56",
    ["jeff"] = path .. "jeff.tga:28:28",
    ["jewworm"] = path .. "jewworm.tga:56:36",
    ["kim"] = path .. "kim.tga:28:28",
    ["KMS"] = path .. "KMS.tga:28:28",
    ["KYN1Kbf"] = path .. "KYN1Kbf.tga:28:28",
    ["lightwork"] = path .. "lightwork.tga:28:28",
    ["mage83"] = path .. "mage83.tga:28:28",
    ["mage_arcane78"] = path .. "mage_arcane78.tga:28:28",
    ["mage_fire76"] = path .. "mage_fire76.tga:28:28",
    ["mage_frost27"] = path .. "mage_frost27.tga:28:28",
    ["mammamia"] = path .. "mammamia.tga:28:28",
    ["midget"] = path .. "midget.tga:28:28",
    ["mrclean"] = path .. "mrclean.tga:56:40",
    ["NATTYSUS"] = path .. "NATTYSUS.tga:28:28",
    ["nk"] = path .. "nk.tga:28:56",
    ["nonce"] = path .. "nonce.tga:28:20",
    ["normalorkworm"] = path .. "normalorkworm.tga:28:22",
    ["o7"] = path .. "o7.tga:28:35",
    ["odakap"] = path .. "odakap.tga:28:28",
    ["ohmy"] = path .. "ohmy.tga:28:28",
    ["ork07"] = path .. "ork07.tga:28:28",
    ["orkheart"] = path .. "orkheart.tga:28:28",
    ["paladin"] = path .. "paladin.tga:28:28",
    ["pepegaabove"] = path .. "pepegaabove.tga:28:28",
    ["placeholder2"] = path .. "placeholder2.tga:28:28",
    ["placeholder"] = path .. "placeholder.tga:56:44",
    ["priest"] = path .. "priest.tga:28:28",
    ["psycho"] = path .. "psycho.tga:28:28",
    ["silence"] = path .. "silence.tga:30:56",
    ["SUS"] = path .. "SUS.tga:28:28",
    ["swastika"] = path .. "swastika.tga:28:28",
    ["ta7"] = path .. "ta7.tga:19:28",
    ["tacticalgenius"] = path .. "tacticalgenius.tga:51:78",
    ["ta"] = path .. "ta.tga:28:28",
    ["taught"] = path .. "taught.tga:28:56",
    ["test2"] = path .. "test2.tga:56:42",
    ["test3"] = path .. "test3.tga:56:42",
    ["test"] = path .. "test.tga:56:42",
    ["toast"] = path .. "toast.tga:28:28",
    ["tuh"] = path .. "tuh.tga:28:28",
    ["vaism"] = path .. "vaism.tga:20:72",
    ["waterboy"] = path .. "waterboy.tga:28:28",
    ["willy"] = path .. "willy.tga:12:56",
    ["wipeit"] = path .. "wipeit.tga:28:28",
    ["wow_Death_Knight"] = path .. "wow_Death_Knight.tga:28:28",
    ["wowdh"] = path .. "wowdh.tga:28:28",
    ["wow_Druid"] = path .. "wow_Druid.tga:28:28",
    ["wow_Hunter"] = path .. "wow_Hunter.tga:28:28",
    ["wowmonk"] = path .. "wowmonk.tga:28:28",
    ["wow_Paladin"] = path .. "wow_Paladin.tga:28:28",
    ["wow_Priest"] = path .. "wow_Priest.tga:28:28",
    ["wow_Rogue"] = path .. "wow_Rogue.tga:28:28",
    ["wow_Shaman"] = path .. "wow_Shaman.tga:28:28",
    ["wow_Warlock"] = path .. "wow_Warlock.tga:28:28",
    ["wow_Warrior"] = path .. "wow_Warrior.tga:28:28",
    ["youngthug"] = path .. "youngthug.tga:28:28",
    ["yuh"] = path .. "yuh.tga:42:64",
    ["GOONING"] = path .. "GOONING.tga:32:32",
    ["gooned"] = path .. "gooned.tga:27:32",
    ["chudbrain"] = path .. "chudbrain.tga:32:32",
    ["chud"] = path .. "chud.tga:32:32",
    ["chudthink"] = path .. "chudthink.tga:32:32",
    ["coomer"] = path .. "coomer.tga:32:32",
    ["cope"] = path .. "cope.tga:32:32",
    ["crydge"] = path .. "crydge.tga:32:32",
    ["evilsmirk"] = path .. "evilsmirk.tga:32:32",
    ["greed"] = path .. "greed.tga:32:32",
    ["nobitches"] = path .. "nobitches.tga:32:32",
    ["notroping"] = path .. "notroping.tga:32:32",
    ["wojak"] = path .. "pink_wojak.tga:32:31",
    ["seethe"] = path .. "seethe.tga:32:28",
    ["shhh"] = path .. "shhh.tga:32:32",
    ["sinister"] = path .. "sinister.tga:32:32",
    ["slurpjak"] = path .. "Slurpjak_1.tga:32:32",
    ["soy"] = path .. "soychamp.tga:32:32",
    ["soylook"] = path .. "soylook.tga:32:32",
    ["toobased"] = path .. "toobased.tga:32:32",
    ["worry"] = path .. "worry.tga:32:32",
    ["zoomer"] = path .. "zoomernocap.tga:32:32",
    ["orkworm"] = path .. "orkworm.tga:16:89",
    ["ork"] = path .. "orkworm.tga:16:89",
    ["garf"] = path .. "garf.tga:32:32",
    ["ongarf"] = path .. "ongarf.tga:32:26",
    ["gard"] = path .. "gard.tga:16:89",
    ["scoutjoblads"] = path .. "scoutjoblads.tga:32:32",
    ["ongromp"] = path .. "ongromp.tga:32:32",
    ["inri"] = path .. "inri.tga:32:32",
    ["ork_oke"] = path .. "ork_oke.tga:32:32",
    ["truegenius2"] = path .. "truegenius2.tga:32:32",
    ["mald"] = path .. "mald.tga:32:23",
    ["anebwithhair"] = path .. "anebwithhair.tga:32:23",
    ["dream"] = path .. "dream.tga:16:32",
    ["beating"] = path .. "beating.tga:64:64",
}

TwitchEmotesCuttingBread_AddAnimation(
    path .. "polish.tga",
    37,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 37, -- imageHeight (pixels)
    15       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "awkwardMonke.tga",
    25,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 25, -- imageHeight (pixels)
    20       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "amuletofretard.tga",
    10,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 10, -- imageHeight (pixels)
    15       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "eating.tga",
    42,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 42, -- imageHeight (pixels)
    15       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "yuh2.tga",
    114,      -- nFrames
    56, 56,  -- frameWidth, frameHeight
    56,      -- imageWidth (pixels)
    56 * 114, -- imageHeight (pixels)
    20       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "nuke.tga",
    21,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 21, -- imageHeight (pixels)
    15       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "special.tga",
    50,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 50, -- imageHeight (pixels)
    15       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "ooh.tga",
    28,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 28, -- imageHeight (pixels)
    15       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "AUUGH.tga",
    100,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 100, -- imageHeight (pixels)
    20       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "vegan.tga",
    90,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 90, -- imageHeight (pixels)
    30       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "wooow.tga",
    55,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 55, -- imageHeight (pixels)
    15       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(
    path .. "disappear.tga",
    21,      -- nFrames
    32, 32,  -- frameWidth, frameHeight
    32,      -- imageWidth (pixels)
    32 * 21, -- imageHeight (pixels)
    15       -- framerate (fps) - tweak to preference
)

TwitchEmotesCuttingBread_AddAnimation(path .. "smash.tga", 7, 32, 32, 32, 32 * 7, 30)
TwitchEmotesCuttingBread_AddAnimation(path .. "spit.tga", 13, 32, 32, 32, 32 * 13, 15)
TwitchEmotesCuttingBread_AddAnimation(path .. "classic.tga", 51, 32, 32, 32, 32 * 51, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "ComradePepe.tga", 15, 32, 32, 32, 32 * 15, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "dealwithit.tga", 10, 32, 32, 32, 32 * 10, 30)
TwitchEmotesCuttingBread_AddAnimation(path .. "elclassico.tga", 61, 32, 32, 32, 32 * 61, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "greenclassic.tga", 51, 32, 32, 32, 32 * 51, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "yap.tga", 32, 32, 32, 32, 32 * 32, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "docyap.tga", 19, 32, 32, 32, 32 * 19, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "1984.tga", 30, 32, 32, 32, 32 * 30, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "ret.tga", 24, 32, 32, 32, 32 * 24, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "BANGER.tga", 14, 32, 32, 32, 32 * 14, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "wifecheck.tga", 156, 32, 32, 32, 32 * 156, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "iq.tga", 143, 32, 32, 32, 32 * 143, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "9parse.tga", 264, 32, 32, 32, 32 * 264, 20)
TwitchEmotesCuttingBread_AddAnimation(path .. "assault.tga", 86, 32, 32, 32, 32 * 86, 20)

function cuttingbread_table_length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function cuttingbread_table_concat(t1, t2)
    t3 = {}
    for key, value in pairs(t1) do
        t3[key] = value
    end
    for key, value in pairs(t2) do
        t3[key] = value
    end
    return t3
end

function cuttingbread_suggestion_reloader(suggestions)
    if (judhead_initsuggestions == nil) then
        local combined = cuttingbread_table_concat(AllTwitchEmoteNames, suggestions)
        for _, frameName in pairs(CHAT_FRAMES) do
            local frame = _G[frameName]

            local editbox = frame.editBox;
            local suggestionList = combined;
            local maxButtonCount = 20;

            local autocompletesettings = {
                perWord = true,
                activationChar = ':',
                closingChar = ':',
                minChars = 2,
                fuzzyMatch = true,
                onSuggestionApplied = function(suggestion)
                    UpdateEmoteStats(suggestion, true, false, false);
                end,
                renderSuggestionFN = Emoticons_RenderSuggestionFN,
                suggestionBiasFN = function(suggestion, text)
                    if TwitchEmoteStatistics[suggestion] ~= nil then
                        return TwitchEmoteStatistics[suggestion][1] * 5
                    end
                    return 0;
                end,
                interceptOnEnterPressed = true,
                addSpace = true,
                useTabToConfirm = Emoticons_Settings["AUTOCOMPLETE_CONFIRM_WITH_TAB"],
                useArrowButtons = true,
            }

            SetupAutoComplete(editbox, suggestionList, maxButtonCount, autocompletesettings);
        end
    else
        local i = cuttingbread_table_length(suggestions)
        for name, path in pairs(judhead_emotes) do
            suggestions[i] = name
            i = i + 1
        end
        judhead_initsuggestions(suggestions)
    end
end

local function cuttingbread_main()

    local dropdown = { "cuttingbread" }
    local i = 1
    local suggestions = {}
    for name, path in pairs(cuttingbread_emotes) do
        table.insert(dropdown, name)
        TwitchEmotes:AddEmote(name, name, path)
        suggestions[i] = name
        i = i + 1
    end

    table.insert(TwitchEmotes_dropdown_options, dropdown)

    cuttingbread_suggestion_reloader(suggestions)
end

cuttingbread_main()